//
//  Exercise.swift
//  FactoryMethod
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import Foundation

protocol Exercise {
    var name: String {get}
    var type: String {get}
    
    func start()
    func stop()
}
