//
//  CaruselContentView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 04.03.2024.
//

import SwiftUI

struct CaruselContentView: View {
    var body: some View {
        ZStack {
            CarouselView(views: getChildViews())
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
    
    func getChildViews() -> [CarouselViewChild] {
        var tempViews: [CarouselViewChild] = []
        
        for i in (1...3) {
            tempViews.append(CarouselViewChild(id: i, content: {
                ZStack {
                    Image("\(i)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .mask {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(width: 250, height: 400)
                        }
                }
                .frame(width: 250, height: 400)
                .shadow(radius: 10)
            }))
        }
        return tempViews
    }
}

#Preview {
    CaruselContentView()
}
