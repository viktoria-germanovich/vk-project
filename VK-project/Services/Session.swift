//
//  Session.swift
//  VK-project
//
//  Created by Виктория Германович on 28.08.22.
//

import Foundation
import SwiftKeychainWrapper

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var version = "5.131"
    
    var token: String {
        get {
            return KeychainWrapper.standard.string(forKey: "token") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "token")
        }
    }
    
    var userId: Int {
        get {
            return UserDefaults.standard.integer(forKey: "userId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
    }
    
    var expiresIn: Date? {
        get {
            return UserDefaults.standard.object(forKey: "expiresIn") as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "expiresIn")
        }
    }
    
    static var isTokenValid: Bool {
        
        guard let tokenDate = UserDefaults.standard.object(forKey: "expiresIn") as? Date
        else { return false }
        
        guard let _ = KeychainWrapper.standard.string(forKey: "token")
        else { return false }
        
        let currentDate = Date.init()
        
        return currentDate < tokenDate
    }
}
