//
//  UserViewCell.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 27/05/22.
//

import UIKit

class UserViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = (imgView.frame.size.width ) / 2
        imgView.clipsToBounds = true
        imgView.layer.borderWidth = 3.0
        imgView.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 10
        
        view.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


