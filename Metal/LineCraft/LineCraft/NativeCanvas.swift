//
//  NativeCanvas.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 13.01.2025.
//

import SwiftUI

struct CanvasRepresentable: View {
    @State private var lines: [(startPoint: CGPoint, endPoint: CGPoint)] = []
    @State private var currentStartPoint: CGPoint?
    @State private var currentEndPoint: CGPoint?

    var body: some View {
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
                let text = String(format: "%.2f cm", distance)
                context.draw(Text(text).font(.system(size: 12)).foregroundColor(.red), at: midPoint)
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
    }
    
    // Метод для вычисления длины линии в сантиметрах
    private func calculateLengthInCm(from start: CGPoint, to end: CGPoint) -> Double {
        let dx = end.x - start.x
        let dy = end.y - start.y
        let lengthInPixels = sqrt(dx * dx + dy * dy)
        return lengthInPixels / 37.8 // Преобразование пикселей в сантиметры (предполагаем, что 1 см = 37.8 пикселей)
    }
    
    // Метод для добавления линии
    func addLine(from start: CGPoint, to end: CGPoint) {
        lines.append((start, end))
    }
    
    // Метод для очистки холста
    func clearCanvas() {
        lines.removeAll()
    }
}

struct ContentView: View {
    @State private var startX: String = ""
    @State private var startY: String = ""
    @State private var endX: String = ""
    @State private var endY: String = ""

    @State private var isShowingAlert = false

    @State private var canvas = CanvasRepresentable()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Canvas Drawing")
                    .font(.largeTitle)
                Spacer()
                Button {
                    // Показать alert для ввода координат
                    isShowingAlert = true
                } label: {
                    Image(systemName: "compass.drawing")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button {
                    // Очистить холст
                    canvas.clearCanvas()
                } label: {
                    Image(systemName: "trash")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            canvas
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
        .alert("Введите координаты", isPresented: $isShowingAlert) {
            TextField("Начало X", text: $startX)
                .keyboardType(.decimalPad)
            TextField("Начало Y", text: $startY)
                .keyboardType(.decimalPad)
            TextField("Конец X", text: $endX)
                .keyboardType(.decimalPad)
            TextField("Конец Y", text: $endY)
                .keyboardType(.decimalPad)
            Button("Добавить", action: addLineFromCoordinates)
            Button("Отменить", role: .cancel) {}
        }
    }
    
    private func addLineFromCoordinates() {
        guard let startX = Double(startX),
              let startY = Double(startY),
              let endX = Double(endX),
              let endY = Double(endY) else { return }
        
        let start = CGPoint(x: startX, y: startY)
        let end = CGPoint(x: endX, y: endY)
        
        canvas.addLine(from: start, to: end)
    }
}

