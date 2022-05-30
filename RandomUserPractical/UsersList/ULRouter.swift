//
//  ULRouter.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation
import UIKit
class ULRouter: ULPresenterToRouterProtocol {
    
    static func createModule() -> ULViewController {
        let view = ULViewController()
        let interactor: ULPresenterToInteractorProtocol = ULInteractor()
        let router: ULPresenterToRouterProtocol = ULRouter()
        let presenter: ULViewToPresenterProtocol & ULInteractorToPresenterProtocol = ULPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    func showDetails(from view: ULPresenterToViewProtocol?, with userEntity: User) {
        let nextView = UDRouter.createModule(userEntity: userEntity)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(nextView, animated: true)
        }
    }
}


