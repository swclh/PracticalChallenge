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
        }
        
        nameLabel.text = userHelpers.formatUserName(userName: user.name)
        dobLabel.text = userHelpers.formatDOB(dob: user.dob)
        ageLabel.text = "Age: \(user.dob.age)"
        emailLabel.text = "Email: \(user.email)"
        phoneLabel.text = "Phone Number: \(user.phone)"
        cellLabel.text = "Cell Phone: \(user.cell)"
        
        getPhoto()
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoImage)
        
        let detailStack = UIStackView(arrangedSubviews: [nameLabel, ageLabel, dobLabel, emailLabel, phoneLabel, cellLabel])
        detailStack.axis = .vertical
        detailStack.spacing = 5
        detailStack.distribution = .fillEqually
        detailStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailStack)
        
        
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            photoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            photoImage.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            detailStack.topAnchor.constraint(equalTo: photoImage.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            detailStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            detailStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            detailStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
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
