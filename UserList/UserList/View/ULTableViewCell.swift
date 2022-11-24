//
//  ULTableViewCell.swift
//  UserList
//
//  Created by Yanqi Zhao on 24/11/22.
//

import UIKit
import Kingfisher

class ULTableViewCell: UITableViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var dobLabel: UILabel!
    
    public func configureData(with viewModel: UserViewModel?) {
        guard viewModel != nil else {
            return
        }
        
        let url = URL(string: viewModel!.thumbnailImage!)
        avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))

        nameLabel.text = viewModel!.name
        genderLabel.text = viewModel!.gender
        dobLabel.text = viewModel!.dob
    }
}
