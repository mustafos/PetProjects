//
//  FliatingTextFieldView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 03.04.2024.
//

import SwiftUI

struct FloatingTextFieldView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ZStack {
                FliatingTextField()
            }
            .padding()
        }
    }
}

#Preview {
    FloatingTextFieldView()
}

struct FloatingTextField: View {
    var body: some View {
        ZStack {
            
        }
    }
}
