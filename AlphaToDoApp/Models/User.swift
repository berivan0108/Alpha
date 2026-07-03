//
//  User.swift
//  AlphaToDoApp
//
//  Created by beri on 6.05.2026.
//

import Foundation
struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
