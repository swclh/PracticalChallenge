//
//  ViewController.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 27/05/22.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var usersTable: UITableView!
    @IBOutlet weak var dataSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results = 15
    var baseUrl : String{
        get {
            return "https://randomuser.me/api/?page=3&results=\(results)&seed=abc"
        }
    }
    
    var users = [User]()
    var user = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up delegates
        usersTable.delegate = self
        usersTable.dataSource = self
        searchBar.delegate = self
        //register Custom XIB/NIB Cell for User Table
        usersTable.register(UINib(nibName: "UserViewCell", bundle: nil), forCellReuseIdentifier: "ReuseableUserNib")
        
        loadData()
        
    }
    
    @IBAction func valueChangedOfSegment(_ sender: UISegmentedControl) {
    }
    
    
        
}

// MARK:- Table View Delegate Methods

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseableUserNib", for: indexPath) as! UserViewCell
    
        
        if let name = users[indexPath.row].name, let gender = users[indexPath.row].gender,
           let title = users[indexPath.row].title,let dob = users[indexPath.row].dateOfBirth{
            
            cell.name.text = name
            cell.gender.text = gender
            cell.dateOfBirth.text = UserManager.instance.DateToString(date: dob)
            cell.title.text = title
   
        }
        
        UserManager.instance.getImageByUrl(urlString: users[indexPath.row].thumbnail!) { data in
            cell.imgView.image = UIImage(data: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == users.count - 1 && searchBar.text == ""){
            print("last row")
            
            if self.results < 200 {
                self.results = self.results + 10
                loadData()
                usersTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.user = users[indexPath.row]
        performSegue(withIdentifier: "ToUserDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DetailVC = (segue.destination as? DetailViewController)
        {
            DetailVC.user = self.user
        }
    }
    
    
    /*func loadData(with :String = "")
    {
        ProgressHUD.show()
        if(with == "")
        {
            UserManager.instance.performRequest(urlString: baseUrl) { users in
                
                DispatchQueue.main.async {
                    self.users = users
                    self.usersTable.reloadData()
                    ProgressHUD.dismiss()
                }
                
            }
        }
        else{
            
            let tempHolder = self.results
            self.results = 200
            
            UserManager.instance.performRequest(urlString: baseUrl) { users in
                
                DispatchQueue.main.async {
                    
                    let arr = users.filter {
                        $0.Name?.uppercased().range(of: (self.searchBar.text!).uppercased()) != nil
                    }
                    
                    self.users = arr
                    self.usersTable.reloadData()
                    if self.users.count > 0 {
                        self.usersTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                    ProgressHUD.dismiss()
                }
                
            }
            
            self.results = tempHolder
        }
        
    }*/
    
    
    func loadData()
    {
        
    }
    
    
    
}


extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text?.count == 0)
        {
            
        }
        else
        {
            if(searchBar.text!.count < 2){
                let alert = UIAlertController(title: "Validation", message: "you need to provide atleast two characters", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(action)
                present(alert, animated: true)
            }
            else{
                //loadData(with: searchBar.text!)
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0)
        {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        else
        {
            
        }
    }
}
