//
//  AbstractFactory.swift
//  AbstractFactory
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import Foundation

protocol AbstractFactory {
    func createChair() -> Chair
    func createSofa() -> Sofa
    func createTable() -> Table
}
