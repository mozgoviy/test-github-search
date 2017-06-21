//
//  ModalWebView.swift
//  test-mozghovoy
//
//  Created by Sergey Mozgovoy on 22/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit
public protocol ModalWebViewDelegate: class {
    func hide()
}
class ModalWebView: UIWindow {
    weak var delegate : ModalWebViewDelegate?

    class func viewWithParams (urlString: String?, delegate:ModalWebViewDelegate) -> ModalWebView {
        
        let nib = UINib.init(nibName: "ModalWebView", bundle: nil)
        let webView = nib .instantiate(withOwner: self, options: nil).first as! UIWebView
        let request = URLRequest(url: URL(string: urlString!)!)
        webView.loadRequest(request)
        let myWindow = nib .instantiate(withOwner: self, options: nil).last as! ModalWebView
        myWindow.frame = UIScreen.main.bounds
        webView.center = myWindow.center
        myWindow.addSubview(webView)
        myWindow.delegate = delegate
        myWindow.makeKeyAndVisible()
        return myWindow
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.hide()
    }
    
}

