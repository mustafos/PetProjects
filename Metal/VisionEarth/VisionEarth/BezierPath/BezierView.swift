//
//  BezierView.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 12.01.2025.
//

import SwiftUI

struct BezierView: View {
    @State private var canvas = CanvasRepresentable()
    @State private var isShowingAlert = false
    @State private var startX: String = ""
    @State private var startY: String = ""
    @State private var endX: String = ""
    @State private var endY: String = ""
    
    var body: some View {
        VStack {
            canvas
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
        .navigationTitle("Bezier Canvas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        // Clear canvas action
                        isShowingAlert = true
                    } label: {
                        Image(systemName: "compass.drawing")
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button {
                        // Clear canvas action
                        canvas.clearCanvas()
                    } label: {
                        Image(systemName: "trash")
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
//        .navigationBarTitleDisplayMode(.inline)
        .alert("Введіть координати", isPresented: $isShowingAlert) {
            TextField("Початок X", text: $startX)
                .keyboardType(.decimalPad)
            TextField("Початок Y", text: $startY)
                .keyboardType(.decimalPad)
            TextField("Кінець X", text: $endX)
                .keyboardType(.decimalPad)
            TextField("Кінець Y", text: $endY)
                .keyboardType(.decimalPad)
            Button("Додати", action: addLineFromCoordinates)
            Button("Скасувати", role: .cancel) {}
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

#Preview {
    BezierView()
}
