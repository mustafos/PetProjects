//
//  NativeCanvas.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 13.01.2025.
//

import SwiftUI

struct NativeCanvas: View {
    @State private var canvas = CanvasItem()

    var body: some View {
        VStack {
            canvas
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
        .navigationTitle("Canvas Drawing")
        .navigationBarTitleDisplayMode(.inline)
    }
}

