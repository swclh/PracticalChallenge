//
//  DetailViewController.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 24/10/22.
//

import UIKit

class DetailViewController: UIViewController {

    let user: User
    let userHelpers = UserHelpers()
    let userPhotoFetch = UserPhotoFetch()
    
    private let titleLabel = Label()
    private let nameLabel = Label()
    private let dobLabel = Label()
    private let ageLabel = Label()
    private let emailLabel = Label()
    private let phoneLabel = Label()
    private let cellLabel = Label()
    private let addressLabel = Label()
    private let photoImage = UIImageView()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
            presentationController.prefersGrabberVisible = true
        }

        titleLabel.attributedText = userHelpers.formatBasicInfo(infoType: "Title: ", info: "\(user.name.title)")
        nameLabel.attributedText = userHelpers.formatBasicInfo(infoType: "Name: ", info: "\(user.name.first) \(user.name.last)")
        dobLabel.attributedText = userHelpers.formatDOB(dob: user.dob)
        
        ageLabel.attributedText = userHelpers.formatBasicInfo(infoType: "Age: ", info: "\(user.dob.age)")
        emailLabel.attributedText = userHelpers.formatBasicInfo(infoType: "Email: ", info: "\(user.email)")
        phoneLabel.attributedText = userHelpers.formatBasicInfo(infoType: "Phone Number: ", info: "\(user.phone)")
        cellLabel.attributedText = userHelpers.formatBasicInfo(infoType: "Cellphone: ", info: "\(user.cell)")
        
        getPhoto()
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoImage)
        
        let detailStack = UIStackView(arrangedSubviews: [titleLabel, nameLabel, ageLabel, dobLabel, emailLabel, phoneLabel, cellLabel])
        detailStack.axis = .vertical
        detailStack.spacing = 10
        detailStack.distribution = .fillEqually
        detailStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailStack)
        
        
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            photoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            photoImage.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            detailStack.topAnchor.constraint(equalTo: photoImage.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            detailStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            detailStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            detailStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func getPhoto() {
        userPhotoFetch.fetchPhoto(photoURL: user.picture.large) {
            (photoResult) in
            switch photoResult {
            case let .success(photo):
                self.photoImage.image = photo
            case let .failure(error):
                print("Error fetching image \(error)")
            }
        }
    }
}
