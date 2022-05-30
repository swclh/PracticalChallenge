//
//  ULProtocols.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation

protocol ULPresenterToViewProtocol: AnyObject {
    
    func showTableView()
    
    func loadingContent()
    
    func finishLoading()
    /// Insert number of users of next page
    func insertRows(at: [IndexPath])

    func showError(error: String)

    func deselectRows()
    
    func updateNavigationBar()
    
    func reloadRows()
    
}

protocol ULViewToPresenterProtocol: AnyObject {
    var view: ULViewController? {get set}
    var interactor: ULPresenterToInteractorProtocol? {get set}
    var router: ULPresenterToRouterProtocol? {get set}
    
    var loadMoreUsers: Bool { get }
    
    var pageSize: Int { get set }

    func numberOfRows(section: Int) -> Int
    
    func content(at indexPath: IndexPath, cell: ULTableViewCell)

    func didSelectRow(at: IndexPath)
    
    func willDisplayRow(at: IndexPath)
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func searchBeginWithText(text: String)
}

protocol ULInteractorToPresenterProtocol: AnyObject {
    
    func getUsersFromApiWithSuccess(response: ULEntity)
    
    func getUsersFromApiWithError(error: String)
    
    func getUsersFromStorageWithSuccess(response: ULEntity)
    
    func getUsersFromStorageWithError(error: String)
}

protocol ULPresenterToInteractorProtocol: AnyObject {
    var presenter: ULInteractorToPresenterProtocol?  { get set }
    
    func getUserListFromAPI(result: Int, page: Int)
    
    func getUserListFromStorage()
    
    func storeUserEntities(entities: ULEntity?)
    
    func clearUserListFromStorage()
}

protocol ULPresenterToRouterProtocol: AnyObject {
    static func createModule() -> ULViewController
    
    func showDetails(from: ULPresenterToViewProtocol?, with: User)
}
