//
//  DBManager.swift
//  test-mozghovoy
//
//  Created by Sergey Mozgovoy on 21/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class DBManager: NSObject {
    let resContext = NSManagedObjectContext.mr_default()
    
    
    static let sharedInstance: DBManager = {
        let instance = DBManager()
        return instance
    }()
    
    func createModelWithModel(json: JSON){
        let repo = Repository.mr_findFirstOrCreate(byAttribute: Globals.RepositoryModelJSONKeys.id,withValue: json[Globals.RepositoryModelJSONKeys.id].stringValue)
        repo.descriptionRepo = json[Globals.RepositoryModelJSONKeys.description].stringValue
        repo.html_url = json[Globals.RepositoryModelJSONKeys.html_url].stringValue
        repo.stars = Int64(json[Globals.RepositoryModelJSONKeys.stargazers_count].intValue)
        resContext.mr_saveToPersistentStoreAndWait()
    }
    
    func searchResultArray() -> (Array<Repository>) {
        let array = Repository.mr_findAll()
        return array as! (Array<Repository>)
    }
}
