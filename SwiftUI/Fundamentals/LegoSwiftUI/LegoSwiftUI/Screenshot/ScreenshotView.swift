//
//  ScreenshotView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 12.03.2024.
//

import SwiftUI

struct ScreenshotView: View {
    var body: some View {
        VStack {
            Image(systemName: "hand.raised")
                .imageScale(.large)
                .foregroundStyle(.red)
            Text("Block Screenshot")
        }
        .screenshotProtected(isProtected: true)
    }
    
}

#Preview {
    ScreenshotView()
}
