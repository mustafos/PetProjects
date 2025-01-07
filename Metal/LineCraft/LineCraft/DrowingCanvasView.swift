//
//  DrowingCanvasView.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 10.01.2025.
//

import UIKit

class DrawingCanvasView: CanvasView {
    private var currentPath: UIBezierPath?
    private var lines: [(startPoint: CGPoint, endPoint: CGPoint)] = []
    private var currentStartPoint: CGPoint?
    private var currentEndPoint: CGPoint?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let startPoint = touch.location(in: self)
        
        // Создаем новый путь для текущей линии
        currentPath = UIBezierPath()
        currentPath?.move(to: startPoint)

        // Устанавливаем начальную точку
        currentStartPoint = startPoint
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let currentPath = currentPath else { return }
        let currentPoint = touch.location(in: self)
        
        // Добавляем текущую точку к пути
        currentPath.addLine(to: currentPoint)
        
        // Обновляем отображение
        setNeedsDisplay()
        
        currentEndPoint = currentPoint
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Добавляем линию в массив, только если это завершение рисования
        guard let touch = touches.first else { return }
        let endPoint = touch.location(in: self)
        
        if let startPoint = currentStartPoint {
            lines.append((startPoint: startPoint, endPoint: endPoint))
        }

        // Очищаем текущий путь, чтобы не сохранять синий путь
        currentPath = nil
        currentStartPoint = nil
        currentEndPoint = nil
        
        // Обновляем отображение, чтобы показать только зеленые линии
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Рисуем только завершенные линии (зеленые)
        for (startPoint, endPoint) in lines {
            let path = UIBezierPath()
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            path.lineWidth = 2.0
            UIColor.green.setStroke()
            path.stroke()
            
            // Рисуем координаты начальной и конечной точки
            drawCoordinateLabel(at: startPoint, text: "(\(Int(startPoint.x)), \(Int(startPoint.y)))")
            drawCoordinateLabel(at: endPoint, text: "(\(Int(endPoint.x)), \(Int(endPoint.y)))")
        }
        
        // Рисуем синий путь только в процессе перемещения
        if let currentPath = currentPath {
            UIColor.blue.setStroke()
            currentPath.lineWidth = 2.0
            currentPath.stroke()
        }
    }

    // MARK: - Additional Methods

    /// Добавить линию по координатам
    func addLine(from start: CGPoint, to end: CGPoint) {
        lines.append((startPoint: start, endPoint: end))
        setNeedsDisplay()
    }

    /// Очищает холст, удаляя все линии
    func clearCanvas() {
        lines.removeAll()
        setNeedsDisplay()
    }

    // MARK: - Private Methods
    private func drawCoordinateLabel(at point: CGPoint, text: String) {
        let labelRect = CGRect(
            x: min(max(point.x + 5, 0), self.bounds.width - 80), // Ограничение внутри границ
            y: min(max(point.y - 15, 0), self.bounds.height - 20), // Ограничение внутри границ
            width: 80,
            height: 20
        )
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.red // Контрастный цвет для видимости
        ]
        
        text.draw(in: labelRect, withAttributes: attributes)
    }
}
