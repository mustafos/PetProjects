//
//  SortingChartView.swift
//  AlgoApp
//
//  Created by Mustafa Bekirov on 31.01.2025.
//

import SwiftUI
import Charts

struct SortingChartView: View {
    let items: [Int]
    let firstIndex: Int?
    let secondIndex: Int?
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.sortingSettings) private var settings
    
    var body: some View {
        GeometryReader { proxy in
            Chart {
                ForEach(Array(items.enumerated()), id: \.offset) { (index, value) in
                    BarMark(
                        x: .value("Index", index),
                        y: .value("Value", value),
                        width: .fixed(proxy.size.width / CGFloat(items.count))
                    )
                    .foregroundStyle(barColor(index: index, value: value))
                    .annotation(position: .top) {
                        if settings.showBarValues {
                            Text("\(value)")
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .animation(settings.animationsEnabled ? .linear(duration: settings.animationDuration) : nil, value: items)
            .padding([.leading, .trailing], 10)
        }
    }
    
    private func barColor(index: Int, value: Int) -> Color {
        if index == firstIndex {
            return colorScheme == .dark ? .white : .black
        } else if index == secondIndex {
            return colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.3)
        }
        
        let normalized = Double(value - 1) / 99.0
        let hue = 0.4 * normalized
        return Color(hue: hue, saturation: 0.9, brightness: 0.9)
    }
}

#Preview {
    SortingChartView(
        items: [15, 3, 14, 29, 10, 8, 21, 13, 5, 20],
        firstIndex: 2,
        secondIndex: 5
    )
}
