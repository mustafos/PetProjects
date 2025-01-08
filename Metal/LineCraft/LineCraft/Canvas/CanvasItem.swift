//
//  CanvasItem.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 13.01.2025.
//

import SwiftUI

struct CanvasItem: View {
    @State private var lines: [(startPoint: CGPoint, endPoint: CGPoint)] = []
    @State private var currentStartPoint: CGPoint?
    @State private var currentEndPoint: CGPoint?

    var body: some View {
        VStack {
            Canvas { context, size in
                // Рисуем сетку
                let gridSize: CGFloat = 25 // Размер блока сетки
                let dotSize: CGFloat = 2.0 // Диаметр точки
                
                // Проходим по всем пересечениям сетки
                for y in stride(from: 0, to: size.height, by: gridSize) {
                    for x in stride(from: 0, to: size.width, by: gridSize) {
                        let dotRect = CGRect(
                            x: x - dotSize / 2, // Центрируем точку
                            y: y - dotSize / 2,
                            width: dotSize,
                            height: dotSize
                        )
                        context.fill(Path(ellipseIn: dotRect), with: .color(.gray.opacity(0.5)))
                    }
                }
                
                // Рисуем линии
                for (startPoint, endPoint) in lines {
                    let path = Path { path in
                        path.move(to: startPoint)
                        path.addLine(to: endPoint)
                    }
                    context.stroke(path, with: .color(.green), lineWidth: 2)
                    
                    // Рассчитываем длину и рисуем текст
                    let distance = calculateLengthInCm(from: startPoint, to: endPoint)
                    let midPoint = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
                    let offsetMidPoint = CGPoint(x: midPoint.x, y: midPoint.y - 4) // Смещаем текст вверх на 4 пикселя
                    let text = String(format: "%.2f cm", distance)
                    
                    context.draw(Text(text).font(.system(size: 12)).foregroundColor(.red), at: offsetMidPoint)
                    
                }
                
                // Рисуем текущий путь (если он есть)
                if let currentStartPoint = currentStartPoint, let currentEndPoint = currentEndPoint {
                    let path = Path { path in
                        path.move(to: currentStartPoint)
                        path.addLine(to: currentEndPoint)
                    }
                    context.stroke(path, with: .color(.blue), lineWidth: 2)
                }
            }
            .gesture(DragGesture()
                .onChanged { value in
                    if currentStartPoint == nil {
                        currentStartPoint = value.startLocation
                    }
                    currentEndPoint = value.location
                }
                .onEnded { value in
                    if let startPoint = currentStartPoint, let endPoint = currentEndPoint {
                        lines.append((startPoint, endPoint))
                        currentStartPoint = nil
                        currentEndPoint = nil
                    }
                })
            
            // Кнопка для удаления всех линий
            Button("Очистить линии") {
                lines.removeAll()
            }
            .padding()
            .background(Color.red.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
    
    // Метод для вычисления длины линии в сантиметрах
    private func calculateLengthInCm(from start: CGPoint, to end: CGPoint) -> Double {
        let dx = end.x - start.x
        let dy = end.y - start.y
        let lengthInPixels = sqrt(dx * dx + dy * dy)
        return lengthInPixels / 37.8 // Преобразование пикселей в сантиметры (предполагаем, что 1 см = 37.8 пикселей)
    }
}
