//
//  ViewController.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 27/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usersTable: UITableView!
    @IBOutlet weak var mage: UIImageView!
    @IBOutlet weak var dataSegment: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let baseUrl = "https://randomuser.me/api/?results=50"
    
    var users = [User]()
    
    var img : Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTable.delegate = self
        usersTable.dataSource = self
        usersTable.register(UINib(nibName: "UserViewCell", bundle: nil), forCellReuseIdentifier: "ReuseableUserNib")
        
        loadData()
        
    }
    
    @IBAction func valueChangedOfSegment(_ sender: UISegmentedControl) {
    }
    
        
        
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseableUserNib", for: indexPath) as! UserViewCell
    
        
        if let name = users[indexPath.row].Name, let gender = users[indexPath.row].Gender,
           let title = users[indexPath.row].title,let dob = users[indexPath.row].DateOfBirth{
            
            cell.name.text = name
            print(name)
            print(gender)
            print(UserManager.DateToString(date: dob))
            print(title)
            
            cell.gender.text = gender
            cell.dateOfBirth.text = UserManager.DateToString(date: dob)
            cell.title.text = title
            
            
        }
        
        if users[indexPath.row].Thumbnail != nil{
            cell.imgView.image = UIImage(data: users[indexPath.row].Thumbnail!)
            print("found data")
            
        }
        else{
            cell.imgView.image = UIImage(systemName: "person")
            cell.imgView.image?.withTintColor(UIColor.white)
            print("couldnt found data")
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func loadData()
    {
        UserManager.instance.performRequest(urlString: baseUrl) { users in
            self.users = users
            DispatchQueue.main.async {
                self.usersTable.reloadData()
            }
            
        }
    }
    
    
    
    
}


