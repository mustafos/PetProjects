//
//  CustomProgressBar.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 16.11.2023.
//

import SwiftUI

class TimerManager: ObservableObject {
    @Published var displayedValue: CGFloat = 0
    @Published var showValue = false
    var value = 0.5
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [self] timer in
            if showValue {
                if displayedValue < value {
                    displayedValue += 0.01
                } else {
                    timer.invalidate()
                }
            } else {
                if displayedValue > 0 {
                    displayedValue -= 0.01
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}

struct CustomProgressBar: View {
    @ObservedObject var tm = TimerManager()
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 24)
                .frame(width: 200, height: 200)
                .shadow(color: .secondary.opacity(0.1), radius: 10, x: 10, y: 10)
            Circle()
                .stroke(lineWidth: 0.34)
                .frame(width: 175, height: 175)
                .foregroundStyle(Color.secondary.opacity(0.3).gradient)
                .overlay {
                    Circle()
                        .stroke(.secondary.opacity(0.1), lineWidth: 2)
                        .blur(radius: 5)
                        .mask {
                            Circle()
                                .foregroundStyle(Color.secondary.gradient)
                        }
                }
            Circle()
                .trim(from: 0, to: tm.showValue ? tm.value : 0)
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(.green.gradient)
            NumValue(displayedValue: tm.displayedValue, color: .secondary)
        }
        .onTapGesture {
            withAnimation(.spring().speed(0.2)) {
                tm.showValue.toggle()
                tm.startTimer()
            }
        }
    }
}

#Preview {
    CustomProgressBar()
}

struct NumValue: View {
    var displayedValue: CGFloat
    var color: Color
    var body: some View {
        Text("\(Int(displayedValue * 100))%")
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .foregroundStyle(color)
    }
}
