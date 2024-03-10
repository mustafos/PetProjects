//
//  ImplementationView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 10.03.2024.
//

import SwiftUI
import UIKit

struct ImplementationView: View {
    var body: some View {
        VStack {
            UILabelWrapper(text: "This is UILabel")
        }
        .padding()
    }
}

#Preview {
    ImplementationView()
}

struct UILabelWrapper: UIViewRepresentable {
    
    var text: String
    
    // Return the type of ui view wanted
    func makeUIView(context: Context) -> some UILabel {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
    
    // Update UI elements
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
}
