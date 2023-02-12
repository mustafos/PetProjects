//
//  Settings.swift
//  Singleton
//
//  Created by Mustafa Bekirov on 11.02.2023.
//

import UIKit

class Settings {
    static let shared = Settings()
    
    var colorStyle = UIColor.white
    var volumeLavel: Float = 1.0
    
    private init() {}
}
