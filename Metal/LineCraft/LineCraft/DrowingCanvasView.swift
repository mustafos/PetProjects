//
//  DrowingCanvasView.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 10.01.2025.
//

import UIKit

class DrawingCanvasView: CanvasView {
    private var currentPath: UIBezierPath?
    private var paintLine: [(path: UIBezierPath, color: UIColor)] = [] // Хранение линий с их цветом
    private var lines: [(startPoint: CGPoint, endPoint: CGPoint)] = []
    private var currentStartPoint: CGPoint?
    private var currentEndPoint: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let startPoint = touch.location(in: self)
        
        // Создаём новый путь для текущей линии
        currentPath = UIBezierPath()
        currentPath?.move(to: startPoint)
        
        // Добавляем линию в массив с цветом
        if let path = currentPath {
            paintLine.append((path: path, color: .blue)) // Устанавливаем цвет синий
        }
        /////////
        guard let touch = touches.first else { return }
        currentStartPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let currentPath = currentPath else { return }
        let currentPoint = touch.location(in: self)
        
        // Добавляем текущую точку к линии
        currentPath.addLine(to: currentPoint)
        
        // Перерисовываем view
        setNeedsDisplay()
        
        ///////////////
        guard let touch = touches.first, let startPoint = currentStartPoint else { return }
        
        // Просто обновляем конечную точку без добавления в lines
        currentEndPoint = touch.location(in: self)
        setNeedsDisplay()  // Перерисовываем, чтобы линия обновлялась
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Завершаем текущую линию
        currentPath = nil
        ///////////////////
        guard let touch = touches.first, let startPoint = currentStartPoint else { return }
        let endPoint = touch.location(in: self)
        
        // Добавляем только одну прямую линию в массив
        lines.append((startPoint: startPoint, endPoint: endPoint))
        
        currentStartPoint = nil
        currentEndPoint = nil
        setNeedsDisplay()  // Перерисовываем, чтобы линия отобразилась окончательно
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Рисуем все сохранённые линии
        for (path, color) in paintLine {
            color.setStroke() // Устанавливаем цвет для линии
            path.lineWidth = 2.0
            path.stroke()
        }
        ///////////////////
        // Рисуем все сохранённые линии
        for (startPoint, endPoint) in lines {
            // Рисуем прямую линию
            let path = UIBezierPath()
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            path.lineWidth = 2.0
            
            UIColor.blue.setStroke()
            path.stroke()
            
            // Подписываем координаты начальной точки
            drawCoordinateLabel(at: startPoint, text: "(\(Int(startPoint.x)), \(Int(startPoint.y)))")
            
            // Подписываем координаты конечной точки
            drawCoordinateLabel(at: endPoint, text: "(\(Int(endPoint.x)), \(Int(endPoint.y)))")
        }
    }
    
    // MARK: - Additional Methods
    
    /// Add a line by coordinates
    func addLine(from start: CGPoint, to end: CGPoint) {
        lines.append((startPoint: start, endPoint: end))
        setNeedsDisplay()
    }
    
    /// Очищает холст, удаляя все линии
    func clearCanvas() {
        paintLine.removeAll()
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

import UIKit

class DrawingCanvasView2: UIView {
    private var lines: [(startPoint: CGPoint, endPoint: CGPoint)] = []
    private var currentStartPoint: CGPoint?
    private var currentEndPoint: CGPoint?
    
    // Для малювання вручну
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        currentStartPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let startPoint = currentStartPoint else { return }
        
        // Просто обновляем конечную точку без добавления в lines
        currentEndPoint = touch.location(in: self)
        setNeedsDisplay()  // Перерисовываем, чтобы линия обновлялась
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let startPoint = currentStartPoint else { return }
        let endPoint = touch.location(in: self)
        
        // Добавляем только одну прямую линию в массив
        lines.append((startPoint: startPoint, endPoint: endPoint))
        
        currentStartPoint = nil
        currentEndPoint = nil
        setNeedsDisplay()  // Перерисовываем, чтобы линия отобразилась окончательно
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Рисуем все сохранённые линии
        for (startPoint, endPoint) in lines {
            // Рисуем прямую линию
            let path = UIBezierPath()
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            path.lineWidth = 2.0
            
            UIColor.blue.setStroke()
            path.stroke()
            
            // Подписываем координаты начальной точки
            drawCoordinateLabel(at: startPoint, text: "(\(Int(startPoint.x)), \(Int(startPoint.y)))")
            
            // Подписываем координаты конечной точки
            drawCoordinateLabel(at: endPoint, text: "(\(Int(endPoint.x)), \(Int(endPoint.y)))")
        }
    }

    private func drawLengthLabel(from startPoint: CGPoint, to endPoint: CGPoint) {
        let distance = hypot(endPoint.x - startPoint.x, endPoint.y - startPoint.y)
        let distanceString = String(format: "%.2f", distance)
        
        let labelRect = CGRect(
            x: (startPoint.x + endPoint.x) / 2 - 20,
            y: (startPoint.y + endPoint.y) / 2 - 10,
            width: 40,
            height: 20
        )
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.black
        ]
        
        distanceString.draw(in: labelRect, withAttributes: attributes)
    }
    
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
    
    // Додати лінію за заданими координатами
//    func addLine(from startPoint: CGPoint, to endPoint: CGPoint) {
//        lines.append((startPoint: startPoint, endPoint: endPoint))
//        setNeedsDisplay()
//    }
    
    // Очищення канваса
    func clearCanvas() {
        lines.removeAll()
        setNeedsDisplay()
    }
}
