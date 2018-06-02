//
//  AlamofireLogbook.swift
//  AlamofireLogbookRequestsList
//
//  Created by Michael Attia on 3/23/18.
//  Copyright © 2018 TSSE. All rights reserved.
//

import UIKit

class AlamofireLogbookRequestsList: UITableViewController, UISearchResultsUpdating {
    
    private static var bundle: Bundle  = {
        let frameworkBundle = Bundle(for: AlamofireLogbookRequestsList.self)
        let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("AlamofireLogbook.bundle")
        return Bundle(url: bundleURL!)!
    }()
    
     static func show(){
        guard let navigationController = UIStoryboard(name: "AlamofireLogbook", bundle: bundle).instantiateInitialViewController() as? UINavigationController,
            let listView = navigationController.viewControllers[0] as? AlamofireLogbookRequestsList else{return}
        listView.requestsList = AlamofireLogbook.shared.requestsList
        UIApplication.topVC()?.present(navigationController, animated: true, completion: nil)
    }
    
    let viewDetailsSegueId = "requestDetails"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var requestsList: [LogItem] = []
    private var filteredList: [LogItem] = []
    private var showingSearchResults: Bool = false
    private var highlightedText: String{
        return searchController.searchBar.text ?? ""
    }
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        }
        searchController.searchBar.placeholder = "Search Requests"
        searchController.hidesNavigationBarDuringPresentation = false;
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // adding back button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clear))
    }
    
    @objc private func cancel(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func clear(){
        AlamofireLogbook.shared.clearCache()
        self.requestsList = []
        self.tableView.reloadData()
        
    }
    
    //MARK: UITableViewDelegate & DataSource
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showingSearchResults{
            return filteredList.count
        }else{
            return requestsList.count
        }
    }
    
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let requestItem: LogItem
        if showingSearchResults{
            requestItem = filteredList[indexPath.row]
        }else{
            requestItem = requestsList[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestItem")!
        cell.textLabel?.text = requestItem.responseStatusCode
        switch requestItem.responseStatus{
        case .success:
            cell.textLabel?.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        case .serverFailure:
            cell.textLabel?.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        case .failure:
            cell.textLabel?.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.accessoryType = .none
        }
        let requestPath = "\(requestItem.requestMethod.uppercased()): \(requestItem.requestURL)"
        cell.detailTextLabel?.setHighlightedText(requestPath, highlight: highlightedText)
        return cell
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let requestItem: LogItem
        if showingSearchResults{
            requestItem = filteredList[indexPath.row]
        }else{
            requestItem = requestsList[indexPath.row]
        }
        switch requestItem.responseStatus{
        case .success, .serverFailure:
            performSegue(withIdentifier: viewDetailsSegueId, sender: requestItem)
        default: return
        }
    }
    
    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == viewDetailsSegueId,
            let view = segue.destination as? NetworkLogRequestDetails,
            let item = sender as? LogItem else {return}
        view.requestItem = item
    }
    
    //MARK: - UISearchResultsUpdating
    
     func updateSearchResults(for searchController: UISearchController) {
        showingSearchResults = searchController.isActive
        if showingSearchResults{
            let searchText = searchController.searchBar.text?.lowercased() ?? ""
            filteredList = requestsList.filter({ (request) -> Bool in
                if request.requestURL.lowercased().contains(searchText){
                    return true
                }else{
                    return false
                }
            })
        }else{
            filteredList = []
        }
        self.tableView.reloadData()
    }


}
