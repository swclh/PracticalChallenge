//
//  ULTableViewCell.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import UIKit
import Kingfisher

class ULTableViewCell: UITableViewCell {
    static let nibName = "ULTableViewCell"

    @IBOutlet weak var avatarContainer: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatarView.roundedRectShadow(cornerRadius: 48, shadowRadius: 5, containerView: self.avatarContainer)
    }
    
    func configure(usr: User?) {
        if let user = usr{
            self.nameLabel.text = (user.name.title ?? "") + " " + (user.name.first ?? "") + " " + (user.name.last ?? "")
            if let dob = user.dob.date {
                self.dobLabel.text = "DOB: \(DateUtils.formatDob(DateUtils.parse(dob)!))"
            } else {
                self.dobLabel.text = "DOB: unknown"
            }
            if user.gender != nil {
                self.genderLabel.text = "Gender: \(user.gender == "male" ? "♂️" : "♀️")"
            } else {
                self.genderLabel.text = "Gender: unknown"
            }
            if let nat = user.nat {
                self.nationalityLabel.text = "Nationality: \(nat.flag())"
            } else {
                self.nationalityLabel.text = "Nationality: unknown"
            }
            
            let avatarPlaceholder = UIImage(named: "icon")
            if let avatarUrl = user.picture.medium {
                let url = URL(string: avatarUrl)
                self.avatarView.kf.setImage(with: url)
            } else {
                self.avatarView.image = avatarPlaceholder
            }
        }
    }
}

extension UIImageView {
    
    func roundedRectShadow(cornerRadius: CGFloat, shadowRadius: CGFloat, containerView: UIView) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true

        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = shadowRadius
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadius).cgPath
        containerView.clipsToBounds = false
    }
    
}

extension String {
    
    func flag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
