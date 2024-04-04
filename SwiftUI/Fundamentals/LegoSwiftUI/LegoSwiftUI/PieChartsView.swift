//
//  PieChartsView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 04.04.2024.
//

import SwiftUI
import Charts

var monthlyExpenses = [
    (expense: "Rent", amount: 350),
    (expense: "Food", amount: 300),
    (expense: "Electricity", amount: 100),
    (expense: "Internet", amount: 50),
    (expense: "Fuel", amount: 100),
    (expense: "Misc", amount: 100)
]
struct PieChartsView: View {
    var body: some View {
        ZStack {
            Chart {
                ForEach(monthlyExpenses, id: \.expense) { expense in
                    SectorMark(
                        angle: .value("Expense", expense.amount),
                        innerRadius: .ratio(0.6),
                        angularInset: 2.0
                    )
                    .foregroundStyle(by: .value("Type", expense.expense)) // Multicolor Chart
                    .cornerRadius(10)
                    .annotation(position: .overlay) {
                        Text("\(expense.amount)$")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
            }
        }
        .frame(height: 500)
        .padding(30)
    }
}

#Preview {
    PieChartsView()
}
