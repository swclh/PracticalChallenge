//
//  ULPresenter.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation
import UIKit
class ULPresenter: ULViewToPresenterProtocol {
    var loadMoreUsers: Bool = true
    var pageSize: Int = 10
    
    let loadingOffset: Int = 5
    var data: ULEntity?
    var searchString: String?

    var view: ULViewController?
    var interactor: ULPresenterToInteractorProtocol?
    var router: ULPresenterToRouterProtocol?
    
    init( view: ULViewController, interactor: ULPresenterToInteractorProtocol, router: ULPresenterToRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func numberOfRows(section: Int) -> Int {
        return self.data?.results.count ?? 0
    }
    
    func content(at indexPath: IndexPath, cell: ULTableViewCell) {
        cell.configure(usr: self.data?.results[indexPath.row] ?? nil)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let userData = self.data?.results[indexPath.row] else {
            return
        }
        
        self.router?.showDetails(from: self.view, with: userData)
    }
    
    func willDisplayRow(at indexPath: IndexPath) {
        guard let data = self.data else {
            return
        }
        
        if indexPath.row == data.results.count - self.loadingOffset {
            self.getUsers(pageNumber: data.info.page + 1)
        }
    }
    
    func viewDidLoad() {
        self.view?.showTableView()
        self.view?.loadingContent()
        self.view?.updateNavigationBar()
        self.getUsers(pageNumber: 1)
    }
    
    func viewWillAppear() {
        self.view?.deselectRows()
    }
    
    func searchBeginWithText(text: String) {
        searchString = text
        
    }
    
    func searchEnds() {
        searchString = nil
    }
}
extension ULPresenter: ULInteractorToPresenterProtocol {
    func getUsersFromApiWithSuccess(response: ULEntity) {
        if response.info.results < self.pageSize {
            self.loadMoreUsers = false
        }
        
        var offset: Int = 0
        
        if let _ = self.data {
            offset = self.data?.results.count ?? 0
            self.data?.results.append(contentsOf: response.results)
            self.data?.info = response.info
        } else {
            self.data = response
            self.view?.finishLoading()
        }
        
        let indexPaths = getUsersFromFilter(users: response.results).enumerated().map({ return IndexPath(row: offset + $0.offset, section: 0) })
        self.view?.insertRows(at: indexPaths)
        
        
        self.interactor?.storeUserEntities(entities: self.data)
    }
    
    func getUsersFromApiWithError(error: String) {
        let message = "\(error) \(NSLocalizedString("ShowingOldData", tableName: "UserList", comment: ""))"
        self.view?.showError(error: message)
        self.interactor?.getUserListFromStorage()
    }
    
    func getUsersFromStorageWithSuccess(response: ULEntity) {
        self.data = response
        self.loadMoreUsers = false
        
        self.view?.finishLoading()
        let indexPaths = getUsersFromFilter(users: response.results).enumerated().map({ return IndexPath(row: $0.offset, section: 0) })
        self.view?.insertRows(at: indexPaths)
    }
    
    func getUsersFromStorageWithError(error: String) {
        self.view?.showError(error: error)
    }
    
    func getUsersFromFilter (users: [User]) -> [User] {
        if let stringToSearch = searchString {
            return users.filter{ ($0.name.first?.contains(stringToSearch) ?? false) || ($0.name.last?.contains(stringToSearch) ?? false)}
        }
        
        return users
    }
}

extension ULPresenter {
    func getUsers(pageNumber: Int) {
        if self.loadMoreUsers {
            self.interactor?.getUserListFromAPI(result: self.pageSize, page: pageNumber)
        }
    }
}
