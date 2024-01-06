//
//  ToDo.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 31.08.2023.
//

import Foundation

struct ToDo: Decodable {
    let id: Int
    let createdAt: String
    let text: String
    let userUid: String
}

struct  ToDoPlayLoad: Codable {
    let text: String
    let userUid: String
    
    private enum CodingKeys: String, CodingKey {
        case text
        case userUid = "user_uid"
    }
}
