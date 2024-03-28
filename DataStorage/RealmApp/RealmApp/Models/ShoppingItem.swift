//
//  ShoppingItem.swift
//  RealmApp
//
//  Created by Mustafa Bekirov on 18.12.2023.
//

import Foundation
import RealmSwift

class ShoppingItem: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var quantity: Int
    @Persisted var category: String
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
