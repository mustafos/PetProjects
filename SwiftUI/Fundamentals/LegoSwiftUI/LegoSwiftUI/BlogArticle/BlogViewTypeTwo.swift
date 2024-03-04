//
//  BlogViewTypeTwo.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 04.03.2024.
//

import SwiftUI

struct BlogViewTypeTwo: View {
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    HeaderView()
                    ArticleTextView(text: "The art of being an artist", size: 38)
                        .padding(.top, 30)
                        .shadow(radius: 2)
                    
                    HStack {
                        Image("1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .mask {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 65, height: 65)
                            }
                            .shadow(radius: 10)
                            .frame(width: 65, height: 65)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ArticleTextView(text: "Helen of Troy", size: 18)
                            ArticleTextView(text: "2m Ago", isBold: false, size: 18)
                                .opacity(0.4)
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 44, height: 24)
                                .padding(.trailing, 20)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 44, height: 24)
                                .padding(.trailing, 20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
            Spacer()
            Image(systemName: "ellipsis")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func ArticleTextView(text: String, isBold: Bool = true, size: CGFloat) -> some View {
        Text(text)
            .font(MadimiOneFont(isBold: isBold, size: size))
    }
}

#Preview {
    BlogViewTypeTwo()
}
