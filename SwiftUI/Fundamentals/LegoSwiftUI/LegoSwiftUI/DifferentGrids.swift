//
//  GridsView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 06.04.2024.
//

import SwiftUI

//MARK: – LazyVGridsView
struct LazyVGridsView: View {
    //    let columns = [GridItem(.adaptive(minimum: 60))]
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, pinnedViews: .sectionHeaders) {
                Section {
                    ForEach(MockData.colors, id: \.self) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill($0.gradient)
                            .frame(height: 100)
                    }
                } header: {
                    Text("Favourites")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                }
                
                Section {
                    ForEach(MockData.colors, id: \.self) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill($0.gradient)
                            .frame(height: 100)
                    }
                } header: {
                    Text("Another Section")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}

//MARK: – LazyHGridsView
struct LazyHGridsView: View {
    let rows = Array(repeating: GridItem(.fixed(100)), count: 3)
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(MockData.colors, id: \.self) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill($0.gradient)
                        .frame(width: 100)
                }
            }
            .padding()
        }
    }
}

//MARK: – StaticGridsView
//struct StaticGridsView: View {
//    @State private var isOn: Bool = false
//    var body: some View {
//        Grid(alignment: .center, horizontalSpacing: 30, verticalSpacing: 30) {
//            GridRow {
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(.red.gradient)
//                    .frame(width: 100, height: 100)
//                
//                VStack {
//                    Circle()
//                        .foregroundStyle(.secondary)
//                        .frame(width: 60, height: 60)
//                    Text("Sean")
//                }
//                
//                VStack {
//                    Button("Press") {
//                        isOn.toggle()
//                    }
//                    .padding(10)
//                    .foregroundStyle(.white)
//                    .background(isOn ? .gray : .blue)
//                    .cornerRadius(16)
//                    
//                    Toggle("Volume", isOn: $isOn)
//                        .labelsHidden()
//                }
//            }
//            
//            Divider()
//            
//            GridRow {
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(.teal.gradient)
//                    .frame(height: 100)
//                    .gridCellColumns(3)
//            }
//        }
//        .padding
//    }
//}

//#Preview {
    //    LazyVGridsView()
    //    LazyHGridsView()
//    StaticGridsView()
//}

struct MockData {
    static var colors: [Color] {
        var array: [Color] = []
        for _ in 0..<30 {
            array.append(randomColor())
        }
        return array
    }
    
    private static func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}
