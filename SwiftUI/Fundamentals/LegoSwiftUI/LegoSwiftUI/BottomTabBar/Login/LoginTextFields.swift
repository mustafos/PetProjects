//
//  LoginTextFields.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 02.03.2024.
//

import SwiftUI

struct PhoneNumberTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero
    
    var body: some View {
        HStack {
            TextField("", text: $text)
                .foregroundStyle(.white)
                .font(MadimiOneFont(isBold: true, size: 20))
                .keyboardType(.numberPad)
                .padding(EdgeInsets(top: 15, leading: 60, bottom: 15, trailing: 60))
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.onAppear {
                            width = geometry.size.width
                        }
                    }
                }
        }
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0, to: 0.55)
                    .stroke(.gray, lineWidth: 1)
                
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0.565 + (0.44 * (labelWidth / width)), to: 1)
                    .stroke(.gray, lineWidth: 1)
                
                HStack {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        .frame(width: 34, height: 34)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Text(placeholder)
                    .foregroundStyle(.white)
                    .overlay {
                        GeometryReader { geometry in
                            Color.clear.onAppear {
                                labelWidth = geometry.size.width
                            }
                        }
                    }
                    .padding(2)
                    .font(MadimiOneFont(isBold: true, size: 13))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 20, y: -10)
            }
        }
    }
}

struct SecurePasswordTextField: View {
    
    @State private var visibleInout: String = ""
    @State private var isSecured: Bool = true
    
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero
    
    var body: some View {
        HStack {
            TextField("", text: $visibleInout)
                .foregroundStyle(.white)
                .font(MadimiOneFont(isBold: true, size: 20))
                .keyboardType(.alphabet)
                .padding(EdgeInsets(top: 15, leading: 60, bottom: 15, trailing: 60))
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.onAppear {
                            width = geometry.size.width
                        }
                    }
                }
                .onChange(of: visibleInout) { newValue in
                    guard isSecured else { text = newValue; return }
                    if newValue.count >= text.count {
                        let newItem = newValue.filter { $0 != Character("*") }
                        text.append(newItem)
                    } else {
                        text.removeLast()
                    }
                    
                    visibleInout = String(newValue.map { _ in Character("*")})
                }
        }
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0, to: 0.55)
                    .stroke(.gray, lineWidth: 1)
                
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0.565 + (0.44 * (labelWidth / width)), to: 1)
                    .stroke(.gray, lineWidth: 1)
                
                HStack {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        .frame(width: 34, height: 34)
                    
                    Spacer()
                    
                    Button {
                        isSecured.toggle()
                        visibleInout = isSecured ? String(text.map { _ in Character("*")}) : text
                    } label: {
                        Image(systemName: isSecured ? "eye" : "eye.slash")
                            .tint(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Text(placeholder)
                    .foregroundStyle(.white)
                    .overlay {
                        GeometryReader { geometry in
                            Color.clear.onAppear {
                                labelWidth = geometry.size.width
                            }
                        }
                    }
                    .padding(2)
                    .font(MadimiOneFont(isBold: true, size: 13))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 20, y: -10)
            }
        }
    }
}
