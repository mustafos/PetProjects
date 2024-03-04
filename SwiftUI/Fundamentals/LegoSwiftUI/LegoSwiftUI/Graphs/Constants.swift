//
//  Constants.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 23.02.2024.
//

import SwiftUI

let initialExpense = 10
let expenseInterval = 5
let minExpense = 1
let maxExpense = 100

let colorMain = Color.white
let minYScale = 0
let maxYScale = 110
let chartWidth: CGFloat = 350
let chartHeight: CGFloat = 400
let datePointWidth: CGFloat = 80

let graphLineColor = Color.white
let graphLineAreaGradient = LinearGradient(
    gradient: Gradient(colors: [graphLineColor.opacity(1), 
                                graphLineColor.opacity(0.5), .clear]),
    startPoint: .top,
    endPoint: .bottom
)

let expenseDescriptionDate: [String] = ["Food", "Coffee", "Transportation",
                                        "Bill Pay", "Fuel", "Snacks", "MISC"]
