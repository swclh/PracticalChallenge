//
//  UserTableCell.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 23/10/22.
//

import UIKit

class UserTableCell: UITableViewCell {
    
    private let userPhotoFetch = UserPhotoFetch()
    
    let dateFormatter = DateFormatter()
    private let userNameLabel = CellLabel()
    private let genderLabel = CellLabel()
    private let dobLabel = CellLabel()
    private var thumbnailImage = UIImageView()
    private let loadingIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
            thumbnailImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            thumbnailImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant:  -10),
            
            labelStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            labelStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            labelStack.leadingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor, constant: 16),
            labelStack.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserName(userName: User.Name) {
        let userNameFormatted = "\(userName.title) \(userName.first) \(userName.last)"
        userNameLabel.text = "Name: \(userNameFormatted)"
    }
    
    func setGenderLabel(gender: String) {
        genderLabel.text = "Gender: \(gender.uppercased())"
    }
    
    func setDobLabel(dob: User.DateOfBirth) {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let formattedDate = dateFormatter.date(from: dob.date)
        if let unwrappedDate = formattedDate {
            dobLabel.text = "DOB: \(unwrappedDate.formatted(date: .numeric, time: .omitted))"
        } else {
            dobLabel.text = "DOB: \(dob.date)"
        }
    }
    
    func setImage(photos: User.Pictures) {
        // User Medium image size as they are better quality than the thumbnail
        userPhotoFetch.fetchPhoto(photoURL: photos.medium) {
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
