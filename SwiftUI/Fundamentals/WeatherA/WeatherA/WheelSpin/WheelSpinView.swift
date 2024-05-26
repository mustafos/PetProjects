//
//  WheelSpinView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 20.05.2024.
//

import SwiftUI

struct WheelSpinView: View {
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .brown, .pink, .purple, .primary, .gray, .mint, .red, .blue, .green, .yellow, .purple, .orange]
    @State private var spin: Double = 0
    @State private var count: Int = 0
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<count, id: \.self) { index in
                    Pie(startAngle: .degrees(Double(index) / Double(count) * 360), endAngle: .degrees(Double(index + 1) / Double(count) * 360))
                        .fill(colors[index % colors.count])
                }
            }
            .rotationEffect(.degrees(spin))
            
            Spacer()
            Button {
                if count < colors.count {
                    count += 1
                } else {
                    count = 0
                }
            } label: {
                Text("Add Color")
            }
            
            Button {
                withAnimation(.spring(response: 2, dampingFraction: 1.5)) {
                    spin += 360
                }
            } label: {
                Text("Spin")
            }
        }
    }
}

#Preview {
    WheelSpinView()
}


struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addLine(to: center)
        return path
    }
}
