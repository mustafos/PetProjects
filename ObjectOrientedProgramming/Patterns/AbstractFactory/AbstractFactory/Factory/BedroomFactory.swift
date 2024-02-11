//
//  BedroomFactory.swift
//  AbstractFactory
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import Foundation

class BedroomFactory: AbstractFactory {
    func createChair() -> Chair {
        print("Created a chair for the bedroom")
        return ChairBedroom()
    }
    
    func createSofa() -> Sofa {
        print("Created a sofa for the bedroom")
        return SofaBedroom()
    }
    
    func createTable() -> Table {
        print("Created a table for the bedroom")
        return TableKitchen()
    }
}
