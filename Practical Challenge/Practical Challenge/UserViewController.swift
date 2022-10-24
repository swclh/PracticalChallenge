//
//  UserViewController.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 19/10/22.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userStore = UserStore()
    var userTableView = UITableView()
    
    override func loadView() {
        view = UIView()
        // MARK: - Table View
        userTableView.dataSource = self
        userTableView.delegate = self
        userTableView.estimatedRowHeight = 32
        userTableView.register(UserTableCell.self, forCellReuseIdentifier: "UserTableCell")
        userTableView.rowHeight = UITableView.automaticDimension
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userTableView)
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            userTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchNewUsers()
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
    
    private func fetchNewUsers(){
        userStore.fetchUsers() {
            userResult in
            switch userResult {
            case let .success(user):
                self.userStore.users = user
                self.userTableView.reloadData()
            
            case let .failure(error):
                print("Error fetching users: \(error)")
            }
        }
    }
}
