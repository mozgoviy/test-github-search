//
//  SearchBar.swift
//  test-mozghovoy
//
//  Created by Sergey Mozgovoy on 22/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar, UISearchBarDelegate {

    class func viewWithParams (placeholder: String?) -> SearchBar {
        let nib = UINib.init(nibName: "SearchBar", bundle: nil)
        let searchBar = nib .instantiate(withOwner: self, options: nil).first as! SearchBar
        searchBar.placeholder = placeholder
        return searchBar
        
    }
}
