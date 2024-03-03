//
//  LandingPageView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 03.03.2024.
//

import SwiftUI

let captionText: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

struct LandingPageView: View {
    @State private var caption: String = ""
    var body: some View {
        ZStack {
            Image("loginBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(x: -1)
            
            VStack(alignment: .trailing) {
                Spacer()
                VStack(alignment: .trailing, spacing: 10) {
                    GeometryReader { geo in
                        HStack {
                            Spacer()
                            Text("Mobile \nApps Development")
                                .font(MadimiOneFont(isBold: true, size: 32))
                                .multilineTextAlignment(.trailing)
                                .bold()
                                .foregroundStyle(.gray)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: geo.size.width - 50, height: 3)
                                        .foregroundStyle(.white)
                                        .offset(x: -20, y: geo.frame(in: .local).midY)
                                    
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    
                    Text(caption)
                        .font(MadimiOneFont(size: 13))
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.gray.opacity(0.6))
                }
                .offset(x: 0, y: -90)
                
                Spacer()
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .overlay {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 2)
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.white)
                            }
                        }
                        .foregroundStyle(.gray.opacity(0.6))
                }
                .frame(width: 55, height: 55)
            }
            .padding(30)
        }
        .ignoresSafeArea()
        .onAppear {
            typeWriter()
        }
    }
    
    func typeWriter(at position: Int = 0) {
        if position == 0 {
            caption = ""
        }
        if position < captionText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                caption.append(captionText[position])
                typeWriter(at: position + 1)
            }
        }
    }
}

#Preview {
    LandingPageView()
}
