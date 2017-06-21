//
//  APIManager.swift
//  MMA
//
//  Created by Andrey Vysher on 5/19/17.
//  Copyright © 2017 Quandoo GmbH. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager: NSObject {
    
    var headOfUser = [String: Any]()
    let queue = OperationQueue()
    let baseURL = "https://api.github.com/"
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    func getUserInfo(query: String, success: @escaping () -> Void) {
        
        queue.maxConcurrentOperationCount = 1
        headOfUser = ["q":query,"sort":"stars","page":"1","per_page":"15"]
        Repository.mr_truncateAll()
        for i in 1 ... 2 {
            headOfUser["page"] = "\(i)"
            let operation = NetworkOperation(URLString: baseURL + Globals.APIParams.searchRepositoryURL,parametrs:headOfUser) { responseObject, error in
                if responseObject == nil {
                    print("failed: \(String(describing: error))")
                } else {
                    let json = JSON(responseObject!)
                    print(responseObject)
                    let arrayObjects = json["items"].arrayValue
                    for index in 0 ..< arrayObjects.count {
                        DBManager.sharedInstance.createModelWithModel(json: arrayObjects[index])
                    }
                }
            }
            queue.addOperation(operation)
            operation.completionBlock  = {
                print("\(operation.isCancelled)")
                print("\(self.queue.operationCount)")
                if self.queue.operationCount == 0 {
                    success()
                    print("complete")
                    
                }
            }
        }
    }
    
    func cancelAllOperation() {
        queue.cancelAllOperations()
    }
    
    class AsynchronousOperation : Operation {
        
        override var isConcurrent: Bool {
            return true
        }
        
        override var isAsynchronous: Bool {
            return true
        }
        
        private var _executing: Bool = false
        override var isExecuting: Bool {
            get {
                return _executing
            }
            set {
                if (_executing != newValue) {
                    self.willChangeValue(forKey: "isExecuting")
                    _executing = newValue
                    self.didChangeValue(forKey: "isExecuting")
                }
            }
        }
        
        private var _finished: Bool = false;
        override var isFinished
            : Bool {
            get {
                return _finished
            }
            set {
                if (_finished != newValue) {
                    self.willChangeValue(forKey: "isFinished")
                    _finished = newValue
                    self.didChangeValue(forKey: "isFinished")
                }
            }
        }
        
        func completeOperation() {
            isExecuting = false
            isFinished  = true
        }
        
        override func start() {
            if (isCancelled) {
                isFinished = true
                return
            }
            
            isExecuting = true
            
            main()
        }
    }
    
    class NetworkOperation : AsynchronousOperation {
        
        let URLString: String
        let networkOperationCompletionHandler: (_ responseObject: Any?, _ error: Error?) -> ()
        var parametrs =  [String: Any]()
        
        weak var request: Alamofire.Request?
        
        init(URLString: String,parametrs: [String: Any], networkOperationCompletionHandler: @escaping (_ responseObject: Any?, _ error: Error?) -> ()) {
            self.URLString = URLString
            self.parametrs = parametrs
            self.networkOperationCompletionHandler = networkOperationCompletionHandler
            super.init()
        }
        
        override func main() {
            request = Alamofire.request(URLString, method: .get, parameters:parametrs)
                .responseJSON { response in
                    
                    self.networkOperationCompletionHandler(response.result.value, response.result.error)
                    
                    self.completeOperation()
            }
        }
        
        override func cancel() {
            request?.cancel()
            super.cancel()
        }
    }
}
