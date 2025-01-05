//
//  CanvasView.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 12.01.2025.
//

import UIKit

class CanvasView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        let gridSize: CGFloat = 50 // Размер блока сетки
        
        // Горизонтальные линии
        for y in stride(from: 0, to: rect.height, by: gridSize) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: rect.width, y: y))
        }
        
        // Вертикальные линии
        for x in stride(from: 0, to: rect.width, by: gridSize) {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: rect.height))
        }
        
        UIColor.lightGray.setStroke()
//        path.lineWidth = 0.5
        path.stroke()
    }
}
