//
//  SortingSettings.swift
//  AlgoApp
//
//  Created by Mustafa Bekirov on 01.02.2025.
//

import SwiftUI

@Observable
class SortingSettings {
    var animationsEnabled = true
    var showBarValues = true
    var showTimer = true
    var animationDuration: Double = 0.5
    var dataSetType: DataSetType = .small
    
    static let shared = SortingSettings()
    private init() {}
}
