//
//  Globals.swift
//  test-mozghovoy
//
//  Created by Sergey Mozgovoy on 22/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

struct Globals {
    
    // MARK - API Requests params:
    struct APIParams {
        static let searchRepositoryURL = "search/repositories?"
        
    }

    struct CellIdentifiers {
        static let ResultCell                           = "ResultCell"
    }
    
    struct Limits {
        static let nameRepositoryLimit                  = 30
    }
    
    struct RepositoryModelJSONKeys {
        static let id                                   = "id"
        static let description                          = "description"
        static let html_url                             = "html_url"
        static let stargazers_count                     = "stargazers_count"

    }
}
