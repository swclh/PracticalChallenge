//
//  ULInteractor.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation
import Disk
class ULInteractor: ULPresenterToInteractorProtocol {
    weak var presenter: ULInteractorToPresenterProtocol?
    func getUserListFromAPI(result: Int, page: Int) {
        do {
            let apiRouter = APIRouter(numberOfUsersPerList: result, page: page)
            let session = URLSession.shared.dataTask(with: try apiRouter.callApi()) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        self.presenter?.getUsersFromApiWithError(error: error.localizedDescription)
                    }
                } else {
                    if let data = data {
                        do {
                            let decodedData = try JSONDecoder().decode(ULEntity.self, from: data)
                            DispatchQueue.main.async {
                                self.presenter?.getUsersFromApiWithSuccess(response: decodedData)
                            }
                        }
                        catch {
                            DispatchQueue.main.async {
                                self.presenter?.getUsersFromApiWithError(error: error.localizedDescription)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.presenter?.getUsersFromApiWithError(error: ApiError.emptyResponse.localizedDescription)
                        }
                    }
                }
            }
            session.resume()
        }
        catch {
            self.presenter?.getUsersFromApiWithError(error: error.localizedDescription)
        }
    }
    
    func getUserListFromStorage() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            
            guard let strongSelf = self else {
                return
            }
            
            do {
                let entities = try Disk.retrieve("RandomUserPractical/entities.json", from: .applicationSupport, as: ULEntity.self)
                DispatchQueue.main.async {
                    strongSelf.presenter?.getUsersFromStorageWithSuccess(response: entities)
                }
            } catch {
                print("⛔️ Error while retrieving users from disk.")
                DispatchQueue.main.async {
                    strongSelf.presenter?.getUsersFromStorageWithError(error: NSLocalizedString("ErrorRetrieveUsersStorage", tableName: "UserList", comment: ""))
                }
            }
        }
    }
    
    func storeUserEntities(entities: ULEntity?) {
        guard let entities = entities else {
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            do {
                try Disk.save(entities, to: .applicationSupport, as: "RandomUserApp/entities.json")
            } catch {
                print("⛔️ Error while saving users to disk.")
            }
        }
    }
    
    func clearUserListFromStorage() {
        DispatchQueue.global(qos: .utility).async {
            do {
                try Disk.clear(.applicationSupport)
            } catch {
                print("⛔️ Error while deleting users from disk.")
            }
        }
    }
}
