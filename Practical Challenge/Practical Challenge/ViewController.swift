//
//  ViewController.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 19/10/22.
//

import UIKit

class ViewController: UIViewController {

    var userStore = UserStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchNewUsers()
    }
    
    private func fetchNewUsers(){
        userStore.fetchUsers() {
            userResult in
            switch userResult {
            case let .success(user):
                self.userStore.users = user
                print(self.userStore.users)
            
            case let .failure(error):
                print("Error fetching users: \(error)")
            }
        }
    }
}

