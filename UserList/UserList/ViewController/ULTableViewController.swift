//
//  ULTableViewController.swift
//  UserList
//
//  Created by Yanqi Zhao on 24/11/22.
//

import UIKit
import MJRefresh

class ULTableViewController: UITableViewController {

    let viewModel = ULViewModel()
    let footer = MJRefreshAutoNormalFooter()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.configureData {
            self.tableView.reloadData()
        }
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(ULTableViewController.footerRefresh))
        tableView.mj_footer = footer
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    // MARK: - Load more data
    @objc func footerRefresh() {
        viewModel.loadMoreData {
            self.tableView.mj_footer!.endRefreshing()
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ULTableViewCell.classString, for: indexPath) as! ULTableViewCell
        cell.configureData(with: viewModel.getUser(at: indexPath))

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ULDetailViewController.classString, let cell = sender as? ULTableViewCell {
            let destination = segue.destination as! ULDetailViewController
            if let index = tableView.indexPath(for: cell), let userViewModel = viewModel.getUser(at: index) {
                destination.userViewModel = userViewModel
            }
            searchController.dismiss(animated: false)
        }
    }
}

extension ULTableViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    // MARK: - Search
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        viewModel.searchData(searchText: searchText) {
            self.tableView.reloadData()
        }
    }
}
