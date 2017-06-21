//
//  SearchViewController.swift
//  test-mozghovoy
//
//  Created by Sergey Mozgovoy on 22/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrayModels = Array<Repository>()
    var modalView:ModalWebView = ModalWebView()
    var rootWindow: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        rootWindow = UIApplication.shared.keyWindow
        let searchBar = SearchBar.viewWithParams(placeholder: "Search")
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        self.getRepository()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func getRepository() {
        DispatchQueue.main.async {
            self.arrayModels = DBManager.sharedInstance.searchResultArray()
            self.tableView.reloadData()
        }
    }
    func getDataFromServer(query: String) {
        APIManager.sharedInstance.getUserInfo(query: query) {
            self.getRepository()
        }
        
    }
}

extension SearchViewController:UISearchBarDelegate {
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.getDataFromServer(query: searchBar.text!)
    }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        APIManager.sharedInstance.cancelAllOperation()
    }

}

extension SearchViewController:UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Globals.CellIdentifiers.ResultCell) as! ResultCell
        cell.fillDataWithModel(model: self.arrayModels[indexPath.row])
        return cell
    }
    
}
extension SearchViewController:UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        modalView = ModalWebView.viewWithParams(urlString: self.arrayModels[indexPath.row].html_url,delegate:self)
    }
}

extension SearchViewController:ModalWebViewDelegate {
    
    func hide() {
        rootWindow?.makeKeyAndVisible()
    }
}
