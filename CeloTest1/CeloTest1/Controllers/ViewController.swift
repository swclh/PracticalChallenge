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
    @IBOutlet weak var CallAPI: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results = 100
    var offset = 0
    var baseUrl : String{
        get {
            return "https://randomuser.me/api/?results=\(results)"
        }
    }
    
    var users = [User]()
    var user = User()
    var loadedData = [User]()
    
    //definiing Singleton for Database Manager
    let db = DatabaseManager.shared
    let UD = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up delegates
        usersTable.delegate = self
        usersTable.dataSource = self
        searchBar.delegate = self
        
        //register Custom XIB/NIB Cell for User Table
        usersTable.register(UINib(nibName: "UserViewCell", bundle: nil), forCellReuseIdentifier: "ReuseableUserNib")
        self.setApiButton()
        
        //loadData()
        db.DeleteAll(objectType: User.self)
        self.UD.set(false, forKey: "loadedDB")
        self.setApiButton()
    }
    
    @IBAction func CallAPI_clicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Call API to fetch data?", message: "this will get data and Store it Locally", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default) { UIAlertAction in
            
            //Calling Data through API
            UserManager.instance.performRequest(urlString: self.baseUrl) {
                self.loadData()
                self.UD.set(true, forKey: "loadedDB")
                self.setApiButton()
            }
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(action2)
        alert.addAction(action1)
        
        
        present(alert, animated: true)
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
        
        //UserManager Singleton
        UserManager.instance.getImageByUrl(urlString: users[indexPath.row].thumbnail!) { data in
          
            DispatchQueue.main.async {
                cell.imgView.image = UIImage(data: data)
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    //Responsible for Pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == users.count - 1 && searchBar.text == ""){
            print("at last row")
            
            if self.offset < results {
                self.offset = self.offset + 10
                loadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //set sending user
        self.user = users[indexPath.row]
        
        //To Details
        performSegue(withIdentifier: "ToUserDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DetailVC = (segue.destination as? DetailViewController)
        {
            DetailVC.user = self.user
        }
    }

}

//Load Actions
extension ViewController{
    
    func loadData()
    {
        
        ProgressHUD.show()
        
        /*if there is temporary loaded data, append that to the users list instead
         of calling DataBase request*/
        if(!(loadedData.isEmpty)){
            users.removeAll()
            users.append(contentsOf: loadedData)
            loadedData.removeAll()
        }
        else{
        users.append(contentsOf:db.load(objectType: User.self, predicates: [],rows: 10,offset: offset,SortKey: "name"))
        }
        print(users.count)
        
        DispatchQueue.main.async {
            self.usersTable.reloadData()
        }
        
        ProgressHUD.dismiss()
        
    }
    
    func loadData(searchString :String)
    {
        if(searchString == "")
        {
           loadData()
        }
        else
        {
            /*Save loaded data in a temporary array so that you dont have
             to call Database request again*/
            
            loadedData = users
            
            //Search from whole list instead of loaded list
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchString)
            users = db.load(objectType: User.self, predicates: [predicate],rows: results,offset: 0, SortKey: "name")
            
            DispatchQueue.main.async {
                self.usersTable.reloadData()
            }
        }
        
    }
    
    func setApiButton()
    {
        DispatchQueue.main.async {
            if self.UD.bool(forKey: "loadedDB") {
                self.CallAPI.isHidden = true
            }
            else{
                self.CallAPI.isHidden = false
            }

        }
    }
    
    
}

//MARK :- Search Bar Delgate Methods

extension ViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text?.count == 0)
        {
            loadData()
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
                loadData(searchString: searchBar.text!)
            }
        }
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
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
    }
}
