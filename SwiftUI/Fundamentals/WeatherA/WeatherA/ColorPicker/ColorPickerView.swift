//
//  ColorPickerView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 25.12.2023.
//

import SwiftUI

struct ColorPallette: Identifiable {
    var id = UUID()
    var color: Color
}

struct ColorPickerView: View {
    @State private var colors: [ColorPallette] = [ColorPallette(color: .green),
                                                  ColorPallette(color: .yellow),
                                                  ColorPallette(color: .red),
                                                  ColorPallette(color: .orange),
                                                  ColorPallette(color: .cyan),
                                                  ColorPallette(color: .blue),
                                                  ColorPallette(color: .mint),
                                                  ColorPallette(color: .brown),
                                                  ColorPallette(color: .gray),
                                                  ColorPallette(color: .black)]
    @State private var selectedColor: Color = .green
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 100, height: 100)
                .foregroundStyle(selectedColor)
            LazyHGrid(rows: Array(repeating: GridItem(), count: 2), content: {
                ForEach(colors) { color in
                    Circle().frame(width: 40, height: 40)
                        .foregroundStyle(color.color)
                        .opacity(0.8)
                        .scaleEffect(selectedColor == color.color ? 0.7 : 1)
                        .onTapGesture {
                            withAnimation {
                                selectedColor = color.color
                                
                            }
                        }
                        .overlay {
                            Circle().stroke(lineWidth: 3)
                                .foregroundStyle(selectedColor == color.color
                                                 ? .white
                                                 : .clear)
                        }
                }
            })
            .frame(height: 100)
        }
        .padding()
        .background(.black.opacity(0.8), in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ColorPickerView()
}
