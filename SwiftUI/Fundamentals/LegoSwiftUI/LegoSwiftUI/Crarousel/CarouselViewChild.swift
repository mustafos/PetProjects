//
//  CarouselViewChild.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 04.03.2024.
//

import SwiftUI

struct CarouselViewChild: View, Identifiable {
    var id: Int
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}
