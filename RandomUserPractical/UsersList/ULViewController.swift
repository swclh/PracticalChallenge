//
//  ViewController.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import UIKit

fileprivate enum UserListViewIdentifier {
    static let userListCellIdentifier = "UserListCellIdentifier"
    static let tableViewAccessibilityIdentifier = "UserListTableViewIdentifier"
}

class ULViewController: UIViewController {
    var presenter : ULViewToPresenterProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ULTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ULTableViewCell.nibName)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 55.5
        tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = UserListViewIdentifier.tableViewAccessibilityIdentifier
        return tableView
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = UIColor.black
        loader.hidesWhenStopped = true
        return loader
    }()
    
    lazy var searchBar:UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.placeholder = "search users"
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    lazy var headerView:UIView = {
        let hView = UIView()
        return hView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }
}

extension ULViewController: UISearchBarDelegate {
    //MARK: UISearchbar delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.searchBeginWithText(text: searchText)
    }
}

extension ULViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.presenter?.willDisplayRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // add the searchBar
        headerView.addSubview(searchBar)
        
        searchBar.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        searchBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: 0.0).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ULViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ULTableViewCell.nibName) as! ULTableViewCell
        self.presenter?.content(at: indexPath, cell: cell)
        return cell
    }
    
}

extension ULViewController: ULPresenterToViewProtocol {
    func showTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func loadingContent() {
        self.loadingIndicator.startAnimating()
        self.view.addSubview(self.loadingIndicator)
        self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func finishLoading() {
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.removeConstraints(self.loadingIndicator.constraints)
        self.loadingIndicator.removeFromSuperview()
    }
    
    func insertRows(at indexPaths: [IndexPath]) {
        self.tableView.performBatchUpdates({
            self.tableView.insertRows(at: indexPaths, with: .none)
        }, completion: nil)
    }
    
    func reloadRows() {
        self.tableView.reloadData()
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        // to draw attention to error, by haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    func deselectRows() {
        guard let indexPathOfSelectedRow = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        self.tableView.deselectRow(at: indexPathOfSelectedRow, animated: true)
    }
    
    func updateNavigationBar() {
        self.title = NSLocalizedString("UserList", tableName: "UserList", comment: "")
    }
}
