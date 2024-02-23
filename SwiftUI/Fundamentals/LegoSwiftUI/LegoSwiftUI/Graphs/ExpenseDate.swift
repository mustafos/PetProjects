//
//  ExpenseDate.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 23.02.2024.
//

import Foundation

struct ExpenseDate {
    private(set) var allExpenses: [Expense]?
    
    mutating func createExpenseDate(days: Int) {
        self.allExpenses = []
        var selectedExpense = initialExpense
        var add = true
        
        for interval in 0...days {
            switch selectedExpense {
            case (maxExpense - expenseInterval + 1)..<Int.max:
                add = false
            case 0..<(minExpense + expenseInterval):
                add = true
            default:
                add = (Int.random(in: 0...4) == 3) ? !add : add
            }
            
            selectedExpense = add
            ? selectedExpense + Int.random(in: 0...expenseInterval)
            : selectedExpense - Int.random(in: 0...expenseInterval)
            let selectedDate = Calendar.current.date(byAdding: .day, value: (-1 * interval), to: Date())!
            self.allExpenses!.append(Expense(day: selectedDate,
                                             amount: Int.random(in: minExpense..<maxExpense),
                                             description: expenseDescriptionDate.randomElement() ?? ""))
        }
    }
}
