//
//  UserSettings.swift
//  UserDefailts
//
//  Created by Mustafa Bekirov on 31.03.2023.
//

import Foundation

class UserSettings: NSObject, NSCoding {
    var isAuthorized: Bool = false
    
    fileprivate enum UserSettings {
        static let isAuthorized = "isAuthorized"
    }
    
    init(authorized: Bool) {
        isAuthorized = authorized
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(isAuthorized, forKey: UserSettings.isAuthorized)
    }
    
    required init?(coder: NSCoder) {
        isAuthorized = coder.decodeBool(forKey: UserSettings.isAuthorized)
    }
}

