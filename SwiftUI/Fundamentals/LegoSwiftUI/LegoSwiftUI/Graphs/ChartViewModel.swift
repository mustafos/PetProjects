//
//  ChartViewModel.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 23.02.2024.
//

import Foundation

class ChartViewModel: ObservableObject {
    @Published private var expenseDate = ExpenseDate()
    
    init() {
        expenseDate.createExpenseDate(days: 100)
    }
    
    var allExpense: [Expense]? {
        expenseDate.allExpenses
    }
}
