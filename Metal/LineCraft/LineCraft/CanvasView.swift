//
//  CanvasView.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 12.01.2025.
//

//import UIKit
//
//class CanvasView: UIView {
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        
//        let gridSize: CGFloat = 25 // Размер блока сетки
//        let dotSize: CGFloat = 2.0 // Диаметр точки
//        
//        let path = UIBezierPath()
//        
//        // Проходим по всем пересечениям сетки
//        for y in stride(from: 0, to: rect.height, by: gridSize) {
//            for x in stride(from: 0, to: rect.width, by: gridSize) {
//                let dotRect = CGRect(
//                    x: x - dotSize / 2, // Центрируем точку
//                    y: y - dotSize / 2,
//                    width: dotSize,
//                    height: dotSize
//                )
//                let dotPath = UIBezierPath(ovalIn: dotRect)
//                path.append(dotPath)
//            }
//        }
//        
//        // Устанавливаем цвет точек
//        UIColor.lightGray.setFill()
//        path.fill()
//    }
//}

import UIKit

class CanvasView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        let gridSize: CGFloat = 25 // Размер блока сетки
        
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
        path.stroke()
    }
}
