//
//  UserViewController.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 19/10/22.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var userStore = UserStore()
    var userTableView = UITableView()
    var currentTablePage = 1
    var isPaginating = false
    
    override func loadView() {
        view = UIView()
        navigationItem.title = "Users"
        
        // MARK: - Table View
        userTableView.dataSource = self
        userTableView.delegate = self
        userTableView.estimatedRowHeight = 16
        userTableView.register(UserTableCell.self, forCellReuseIdentifier: "UserTableCell")
        userTableView.rowHeight = UITableView.automaticDimension
        
        userTableView.refreshControl = UIRefreshControl()
        userTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        userTableView.refreshControl?.addTarget(self, action: #selector(fetchNewUsers), for: .valueChanged)
        
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userTableView)
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            userTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            userTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            userTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchNewUsers(pagination: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStore.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as! UserTableCell
        let userInfo = userStore.users[indexPath.row]
        
        cell.setUserName(userName: userInfo.name)
        cell.setGenderLabel(gender: userInfo.gender)
        cell.setDobLabel(dob: userInfo.dob)
        cell.setImage(photos: userInfo.picture)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailViewController(user: userStore.users[indexPath.row])
        detailController.modalPresentationStyle = .formSheet
        present(detailController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isPaginating else {
            let position = scrollView.contentOffset.y
            if position > (userTableView.contentSize.height-100-scrollView.frame.size.height) {
                currentTablePage += 1
                fetchNewUsers(pagination: true, currentPage: currentTablePage)
            }
            return
        }
    }
    
    // Fetch new users for the usertable, either a new set or additional users
    @objc private func fetchNewUsers(pagination: Bool, currentPage: Int = 1){
        if pagination {
            isPaginating = true
        }
        userStore.fetchUsers(pagination: pagination, currentPage: currentPage) {
            userResult in
            switch userResult {
            case let .success(user):
                // If pagination append to users rather than overwriting
                if pagination {
                    self.userStore.users.append(contentsOf: user)
                    DispatchQueue.main.async {
                        self.userTableView.reloadData()
                    }
                    self.isPaginating = false
                } else {
                    self.currentTablePage = 1
                    self.userStore.users = user
                    self.userTableView.reloadData()
                    self.userTableView.refreshControl?.endRefreshing()
                }
            
            case let .failure(error):
                print("Error fetching users: \(error)")
            }
        }
    }
}
