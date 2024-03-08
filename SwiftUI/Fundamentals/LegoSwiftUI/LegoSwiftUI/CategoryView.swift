//
//  CategoryView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 16.02.2024.
//

import SwiftUI

var categoriesData = ["All", "Apparel", "Dress", "Tshirt", "Bag"]

struct CategoryView: View {
    var categories: [String]
    @State private var selectedCategory: Int = 0
    var action: (String) -> ()
    
    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { geo in
                ScrollView(.horizontal) {
                    VStack {
                        HStack(spacing: 10) {
                            ForEach(0..<categories.count, id: \.self) { i in
                                CategoryItem(isSelected: i == selectedCategory, title: categories[i])
                                    .onTapGesture {
                                        selectedCategory = i
                                        action(categories[i])
                                    }
                            }
                        }
                    }
                    .frame(width: geo.size.width)
                }
                .scrollIndicators(.never)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CategoryView(categories: categoriesData, action: { value in
        print(value)
    })
}

struct CategoryItem: View {
    var isSelected: Bool = false
    var title: String = "All"
    var body: some View {
        VStack(spacing: 1) {
            Text(title)
                .kerning(1)
                .multilineTextAlignment(.center)
                .foregroundStyle(isSelected ? .yellow : .gray.opacity(0.9))
                .bold(isSelected)
            
            if isSelected {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: 5, height: 5)
                    .rotationEffect(Angle(degrees: 45))
            }
        }
    }
}
