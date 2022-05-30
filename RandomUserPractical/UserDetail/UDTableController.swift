//
//  UDViewController.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation
import UIKit

class UDTableController: UITableViewController {
    @IBOutlet weak var avatarContainer: UIView!
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var flagLabel: UILabel!
    @IBOutlet var genderImageView: UIImageView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var homeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    var presenter: UDViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isAccessibilityElement = true
        self.tableView.accessibilityIdentifier = "UDTableController"
        self.presenter?.viewDidLoad()
    }
}

extension UDTableController: UDPresenterToViewProtocol {
    
    func show(flag: String) {
        self.flagLabel.text = flag
    }
    
    func show(name: String) {
        self.title = name
    }
    
    func show(email: String) {
        self.emailLabel.text = email
    }
    
    func show(userPicture: URL) {
        self.avatarView.roundedRectShadow(cornerRadius: 48, shadowRadius: 5, containerView: self.avatarContainer)
        self.avatarView.kf.setImage(with: userPicture)
    }
    
    func show(cellPhone: String) {
        self.cellLabel.text = cellPhone
    }
    
    func show(homePhone: String) {
        self.homeLabel.text = homePhone
    }
    
    func show(locationAddress: String) {
        self.locationLabel.text = locationAddress
    }
}
