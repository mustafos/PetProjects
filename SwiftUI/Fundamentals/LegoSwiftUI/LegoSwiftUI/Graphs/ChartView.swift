//
//  ChartView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 23.02.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var chartViewModel = ChartViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                expensesSubView(allExpenses: chartViewModel.allExpense!)
            }
        }
    }
    
    @ViewBuilder
    func expensesSubView(allExpenses: [Expense]?) -> some View {
        VStack {
            GroupBox {
                if let expenses = allExpenses {
                    ScrollView(.horizontal) {
                        Chart {
                            ForEach(0..<allExpenses!.count, id: \.self) { i in
                                AreaMark(
                                    x: .value("Day", expenses[i].day),
                                    y: .value("Expense", expenses[i].amount)
                                )
                                .interpolationMethod(.monotone)
                                .foregroundStyle(graphLineAreaGradient)
                                LineMark(
                                    x: .value("Day", expenses[i].day),
                                    y: .value("Expense", expenses[i].amount)
                                    )
                                .foregroundStyle(colorMain)
                                .accessibilityLabel("\(expenses[i].day.toString())")
                                .accessibilityLabel("\(expenses[i].amount)")
                                .interpolationMethod(.monotone)
                                .symbol() {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .opacity(1)
                                            .frame(width: 20)
                                        
                                        VStack {
                                            Text("\(expenses[i].amount)")
                                                .font(.system(size: 10))
                                                .foregroundStyle(.white)
                                        }
                                        .offset(CGSize(width: 0, height: -20))
                                    }
                                }
                            }
                        }
                        .chartYScale(domain: minYScale...maxYScale)
                        .chartYAxis() {
                            AxisMarks(position: .leading) {
                                AxisGridLine(centered: true, stroke: StrokeStyle(dash: [4.0, 4.0]))
                                    .foregroundStyle(.white.opacity(0.4))
                                let value = $0.as(Int.self)!
                                AxisValueLabel {
                                    Text("\(value)")
                                        .foregroundStyle(.white)
                                        .padding([.leading, .trailing], 15)
                                }
                            }
                        }
                        .chartXAxis {
                            AxisMarks(preset: .extended,
                                      position: .bottom,
                                      values: .stride(by: .day)) { value in
                                if value.as(Date.self)!.isFirstOfMonth() {
                                    AxisGridLine()
                                        .foregroundStyle(.black.opacity(0.5))
                                    let label = "01\n\(value.as(Date.self)!.monthName())"
                                    AxisValueLabel(label)
                                        .foregroundStyle(.white)
                                } else {
                                    AxisValueLabel(format: .dateTime.day(.twoDigits))
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .frame(width: datePointWidth * CGFloat(expenses.count))
                    }
                }
            }
            .groupBoxStyle(ChartGroupBoxStyle())
            .frame(height: chartHeight)
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing], 10)
            .shadow(color: .white, radius: 2)
        }
    }
}

#Preview {
    ChartView()
}
