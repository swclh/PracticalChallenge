//
//  ULViewModel.swift
//  UserList
//
//  Created by Yanqi Zhao on 24/11/22.
//

import UIKit
import CoreData

struct UserViewModel {
    var name: String?
    var fullName: String?
    var gender: String?
    var dob: String?
    var thumbnailImage: String?
    var largeImage: String?
    var phone: String?
    var email: String?
    var city: String?
}

class ULViewModel: NSObject {
    
    var fetchResults: NSFetchedResultsController<NSFetchRequestResult>!

    var userCount: Int {
        get {
            fetchResults.fetchedObjects?.count ?? 0
        }
    }
    
    func getUser(at indexPath: IndexPath) -> UserViewModel? {
        let user = fetchResults.object(at: indexPath) as! ULUser
        return UserViewModel(name: user.name?.getTitleName(), fullName: user.name?.getFullName(), gender: user.gender, dob: user.dob?.date, thumbnailImage: user.picture?.thumbnail, largeImage: user.picture?.large, phone: user.phone, email: user.email, city: user.location?.city)
    }
    
    func configureData(callback: @escaping () -> ()) {
        fetchResults = NSFetchedResultsController(fetchRequest: ULUser.configure(), managedObjectContext: core_data_context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResults.delegate = self
        try? fetchResults.performFetch()
        ULNetworkClient.fetchCachedData { isCached in
            try? self.fetchResults.performFetch()
            callback()
        }
    }
    
    func loadMoreData(callback: @escaping () -> ()) {
        ULNetworkClient.fetchCachedData { isCached in
            self.fetchResults.fetchRequest.fetchLimit = ULNetworkClient.loadPage * count_per_page
            try? self.fetchResults.performFetch()
            callback()
        }
    }
}

extension ULViewModel: NSFetchedResultsControllerDelegate {

}
