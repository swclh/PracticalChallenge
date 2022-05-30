//
//  UDPresenter.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation
import UIKit

class UDPresenter: UDViewToPresenterProtocol {
    var view: UDPresenterToViewProtocol?
    var interactor: UDPresenterToInteractorProtocol?
    var router: UDPresenterToRouterProtocol?
    
    var data: User
    
    init( view: UDPresenterToViewProtocol?, interactor: UDPresenterToInteractorProtocol?, router: UDPresenterToRouterProtocol?, userEntity: User) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.data = userEntity
    }
    
    func viewDidLoad() {
        
        let gender = self.data.gender == "male" ? "♂️" : "♀️"
        // Flag
        self.view?.show(flag: gender + " " + self.data.nat!.flag())
        
        // Name
        let name = "\(self.data.name.title?.capitalized ?? "") \(self.data.name.first?.capitalized ?? "") \(self.data.name.last?.capitalized ?? "")"
        self.view?.show(name: name)
        
        // Email
        self.view?.show(email: self.data.email ?? "")
        
        // Cell phone
        self.view?.show(cellPhone: self.data.cell ?? "")
        
        // Home phone
        self.view?.show(homePhone: self.data.phone ?? "")
        
        // Picture
        if let url = URL(string: self.data.picture.large ?? "") {
            self.view?.show(userPicture: url)
        }
        
        
        // Location
        var locationAddress = ""
        if let countryName = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: self.data.nat ?? "") {
            locationAddress = "\(self.data.location.street.name?.capitalized ?? "")\n\(self.data.location.city!.capitalized)\n\(self.data.location.state!.capitalized)\n\(countryName)"
        } else {
            locationAddress = "\(self.data.location.street.name?.capitalized ?? "")\n\(self.data.location.city!.capitalized)\n\(self.data.location.state!.capitalized)"
        }
        self.view?.show(locationAddress: locationAddress)
    }
}
extension UDPresenter: UDInteractorToPresenterProtocol {
    
}
