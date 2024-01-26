//
//  VolkswagenDecorator.swift
//  Decorator
//
//  Created by Mustafa Bekirov on 16.02.2023.
//

import Foundation

class VolkswagenDecorator: VolkswagenProtocol {
    private let decoratorType: VolkswagenProtocol
    
    required init(decorator: VolkswagenProtocol) {
        self.decoratorType = decorator
    }
    
    func getTitle() -> String {
        return decoratorType.getTitle()
    }
    
    func getPrice() -> Double {
        return decoratorType.getPrice()
    }
}
