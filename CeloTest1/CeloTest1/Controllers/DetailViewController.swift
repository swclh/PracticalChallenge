//
//  DetailViewController.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 28/05/22.
//

import UIKit

class DetailViewController: UIViewController {

    
    var user: User?
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var City: UILabel!
    @IBOutlet weak var DateOfBirth: UILabel!
    @IBOutlet weak var Gender: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture.layer.cornerRadius = (profilePicture.frame.size.width ) / 3
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderWidth = 25
        profilePicture.layer.borderColor = UIColor.white.cgColor
        
        setUserValues()
    }
    
    func setUserValues(){
        if let name = user?.Name, let email = user?.Email, let city = user?.City,
           let dob = user?.DateOfBirth, let gender = user?.Gender, let data = user?.ProfilePicture{
            
            print(dob)
            
            Name.text = name
            Email.text = email
            City.text = city
            DateOfBirth.text = UserManager.DateToString(date: dob)
            Gender.text = gender
            
            profilePicture.image = UIImage(data: data)
            
        }
    }
    
    @IBAction func addToLocalData(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    

}