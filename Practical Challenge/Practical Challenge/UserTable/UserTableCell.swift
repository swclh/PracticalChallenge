//
//  UserTableCell.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 23/10/22.
//

import UIKit

class UserTableCell: UITableViewCell {
    
    private let userPhotoFetch = UserPhotoFetch()
    private let userHelpers = UserHelpers()
    
    private let userNameLabel = Label()
    private let genderLabel = Label()
    private let dobLabel = Label()
    private var thumbnailImage = UIImageView()
    private let loadingIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //separatorInset.left = 20.0
        
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thumbnailImage)
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImage.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        
        // MARK: - Label stack
        let labelStack = UIStackView(arrangedSubviews: [userNameLabel, genderLabel, dobLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 5
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            thumbnailImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            thumbnailImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            thumbnailImage.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant:  -8),
            
            labelStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            labelStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            labelStack.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: 16),
            labelStack.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserName(userName: User.Name) {
        userNameLabel.attributedText = userHelpers.formatBasicInfo(infoType: "Name: ", info: "\(userName.title) \(userName.first) \(userName.last)")
    }
    
    func setGenderLabel(gender: String) {
        genderLabel.attributedText = userHelpers.formatBasicInfo(infoType: "Gender: ", info: "\(gender.uppercased())")
    }
    
    func setDobLabel(dob: User.DateOfBirth) {
        dobLabel.attributedText = userHelpers.formatDOB(dob: dob)
    }
    
    func setImage(photos: User.Pictures) {
        // User Medium image size as they are better quality than the thumbnail
        userPhotoFetch.fetchPhoto(photoURL: photos.medium
        ) {
            (photoResult) in
            switch photoResult {
            case let .success(photo):
                self.thumbnailImage.image = photo
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.removeFromSuperview()
            case let .failure(error):
                print("Error fetching image \(error)")
            }
        }
    }
}
