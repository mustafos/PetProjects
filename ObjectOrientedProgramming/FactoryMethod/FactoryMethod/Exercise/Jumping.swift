//
//  Jumping.swift
//  FactoryMethod
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import Foundation

class Jumping: Exercise {
    var name: String = "Jumping"
    
    var type: String = "Leg exercises"
    
    func start() {
        print("Start jumping")
    }
    
    func stop() {
        print("Stop jumping")
    }
}
