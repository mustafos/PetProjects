//
//  FactoryExercises.swift
//  FactoryMethod
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import Foundation

enum Exercises {
    case jumping, squatting
}

class FactoryExercises {
    static let defaultFactory = FactoryExercises()
    
    func createExercise(name: Exercises) -> Exercise {
        switch name {
            case .jumping: return Jumping()
            case .squatting: return Squarts()
        }
    }
}
