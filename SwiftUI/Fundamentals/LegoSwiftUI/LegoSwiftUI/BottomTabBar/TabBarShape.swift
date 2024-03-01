//
//  TabBarShape.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 01.03.2024.
//

import SwiftUI

struct TabBarShape: Shape {
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        let circleWidth = width * 0.2
        
        let point1 = CGPoint(x: 0, y: height)
        let point2 = CGPoint(x: 0, y: height * 0.2)
        let point3 = CGPoint(x: width * 0.4, y: 0)
        let point4 = CGPoint(x: width * 0.8, y: 0)
        let point5 = CGPoint(x: width, y: height)
        
        return Path { path in
            path.move(to: point1)
            path.addLine(to: point2)
            path.addArc(center: .init(x: width * 0.1, y: width * 0.1),
                        radius: width * 0.1 , startAngle: .init(degrees: 180),
                        endAngle: .init(degrees: 270),
                        clockwise: false)
            
            path.addLine(to: point3)
            path.addArc(center: .init(x: xAxis, y: 0),
                        radius: circleWidth / 2, startAngle: .init(degrees: 180),
                        endAngle: .init(degrees: 0),
                        clockwise: true)
            
            path.addLine(to: point4)
            path.addArc(center: .init(x: width * 0.9, y: width * 0.1),
                        radius: width * 0.1 , startAngle: .init(degrees: 270),
                        endAngle: .init(degrees: 0),
                        clockwise: false)
            
            path.addLine(to: point5)
            path.closeSubpath()
        }
    }
}
