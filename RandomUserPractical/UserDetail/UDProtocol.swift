//
//  UDProtocol.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation
import UIKit

protocol UDPresenterToViewProtocol: AnyObject {
    
    func show(userPicture: URL)
    
    func show(flag: String)
    
    func show(name: String)
    
    func show(email: String)
    
    func show(cellPhone: String)
    
    func show(homePhone: String)
    
    func show(locationAddress: String)
}

protocol UDInteractorToPresenterProtocol: AnyObject {
}

protocol UDPresenterToInteractorProtocol: AnyObject {
    var presenter: UDInteractorToPresenterProtocol?  { get set }
}

protocol UDViewToPresenterProtocol: AnyObject {
    var view: UDPresenterToViewProtocol? { get set }
    var interactor: UDPresenterToInteractorProtocol? { get set }
    var router: UDPresenterToRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol UDPresenterToRouterProtocol: AnyObject {
    static func createModule(userEntity: User) -> UIViewController
}


