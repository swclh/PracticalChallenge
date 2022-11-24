//
//  ULNetworkClient.swift
//  UserList
//
//  Created by Yanqi Zhao on 24/11/22.
//

import Foundation
import Alamofire

public class ULNetworkClient {
    static var loadPage = 1
    
    static public func fetchCachedData(callback: @escaping (_ isCached: Bool) -> ()) {
        if loadPage <= UserDefaults.cachedPage {
            callback(true)
            loadPage += 1
        } else {
            fetchNetworkData(callback: callback)
        }
    }
    
    static public func fetchNetworkData(callback: ((_ isCached: Bool) -> ())?) {
        let url = "https://randomuser.me/api/?page=\(loadPage)&results=\(count_per_page)&seed=seed"
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let result):
                if let value = result as? [String: Any] {
                    let users = value["results"] as! [[String: Any]]
                    ULUser.configure()
                    ULUser.appendArray(array: users)
                    UserDefaults.cachedPage += 1
                    loadPage += 1
                }
            case .failure(_):
                break
            }
            
            if callback != nil {
                callback!(false)
            }
        }
    }
}
