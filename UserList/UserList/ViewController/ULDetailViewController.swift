//
//  ULDetailViewController.swift
//  UserList
//
//  Created by Yanqi Zhao on 24/11/22.
//

import UIKit
import Kingfisher

class ULDetailViewController: UIViewController {
    
    var userViewModel: UserViewModel!
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var mailLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var dobLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: userViewModel!.largeImage!)
        avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
        nameLabel.text = userViewModel.fullName
        phoneLabel.text = userViewModel.phone
        mailLabel.text = userViewModel.email
        cityLabel.text = userViewModel.city
        dobLabel.text = userViewModel.dob
    }
}
