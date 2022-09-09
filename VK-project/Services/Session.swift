//
//  Session.swift
//  VK-project
//
//  Created by Виктория Германович on 28.08.22.
//

import Foundation

// Класс-сервис - хранение и управление токеном
final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token: String = " "
    var userId: Int = 0
    var expiresIn: Int = 0
}
