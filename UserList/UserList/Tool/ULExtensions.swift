//
//  ULExtensions.swift
//  UserList
//
//  Created by Yanqi Zhao on 24/11/22.
//

import Foundation

extension NSObject {
    public class var classString: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var classString: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
