//
//  MUser.swift
//  Chats
//
//  Created by Алексей Пархоменко on 10.01.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit
class UsersController {
    struct MUser: Decodable, Hashable {
        var username: String
        var avatarStringURL: String
        var sex: String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func == (lhs: MUser, rhs: MUser) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func contains(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            return username.lowercased().contains(lowercasedFilter)
        }
    }
    
    func filteredUsers(with searchText: String?=nil, limit: Int?=nil) -> [MUser] {
        let filtered = users.filter { $0.contains(searchText) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }
    
    private lazy var users: [MUser] = {
        return Bundle.main.decode([MUser].self, from: "users.json")
    }()
}



