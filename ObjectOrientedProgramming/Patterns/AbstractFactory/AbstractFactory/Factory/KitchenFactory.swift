//
//  KitchenFactory.swift
//  AbstractFactory
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import Foundation

class KitchenFactory: AbstractFactory {
    func createChair() -> Chair {
        print("Created a chair for the kitchen")
        return ChairKitchen()
    }
    
    func createSofa() -> Sofa {
        print("Created a sofa for the kitchen")
        return SofaKitchen()
    }
    
    func createTable() -> Table {
        print("Created a table for the kitchen")
        return TableKitchen()
    }
}
