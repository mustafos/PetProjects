//
//  ThumbnailView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 10.03.2024.
//

import SwiftUI

struct ThumbnailView: View {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}
