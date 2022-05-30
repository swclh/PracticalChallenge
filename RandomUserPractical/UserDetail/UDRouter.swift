//
//  UDRouter.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import UIKit

class UDRouter: UDPresenterToRouterProtocol {
    
    static func createModule(userEntity: User) -> UIViewController {
        let view = UIStoryboard(name: "UDTable", bundle: nil).instantiateViewController(withIdentifier: "UDTableController") as! UDTableController
        let interactor: UDPresenterToInteractorProtocol = UDInteractor()
        let router: UDPresenterToRouterProtocol = UDRouter()
        let presenter: UDViewToPresenterProtocol & UDInteractorToPresenterProtocol = UDPresenter(view: view, interactor: interactor, router: router, userEntity: userEntity)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}
