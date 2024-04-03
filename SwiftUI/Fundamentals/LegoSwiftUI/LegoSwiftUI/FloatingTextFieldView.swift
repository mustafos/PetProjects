//
//  FloatingTextFieldView.swift
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
                FloatingTextField(placeholderText: "Name")
                    .onTextChange { oldValue, newValue in
                        print(newValue)
                    }
            }
            .padding()
        }
    }
}

#Preview {
    FloatingTextFieldView()
}

struct FloatingTextField: View {
    
    @State private var text: String = ""
    @State private var placeholderOffset: CGFloat
    @State private var scaleEffectValue: CGFloat
    
    var placeholderText: String
    let animation: Animation = .spring(response: 0.1, dampingFraction: 0.6)
    
    private var onTextAction: ((_ oldValue: String, _ newValue: String) -> ())?
    
    init(placeholderOffset: CGFloat = 0, scaleEffectValue: CGFloat = 1, placeholderText: String, onTextAction: ((_: String, _: String) -> Void)? = nil) {
        self.placeholderOffset = placeholderOffset
        self.scaleEffectValue = scaleEffectValue
        self.placeholderText = placeholderText
        self.onTextAction = onTextAction
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
           Text(placeholderText)
                .foregroundStyle($text.wrappedValue.isEmpty ? Color.white : Color.gray)
                .font($text.wrappedValue.isEmpty ? .headline : .caption)
                .offset(y: placeholderOffset)
                .scaleEffect(scaleEffectValue, anchor: .leading)
            
            TextField("", text: $text)
                .font(.headline)
                .foregroundStyle(Color.yellow)
        }
        .padding()
        .padding(.vertical, 5)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 2)
        }
        .onChange(of: text) { oldValue, newValue in
            withAnimation(animation) {
                placeholderOffset = $text.wrappedValue.isEmpty ? 0 : -25
                scaleEffectValue = $text.wrappedValue.isEmpty ? 1 : 0.75
            }
            
            onTextAction?(oldValue, newValue)
        }
    }
}

extension FloatingTextField {
    public func onTextChange(_ onTextAction: @escaping ((_ oldValue: String, _ newValue: String) -> ())) -> Self {
        var view = self
        view.onTextAction = onTextAction
        return view
    }
}
