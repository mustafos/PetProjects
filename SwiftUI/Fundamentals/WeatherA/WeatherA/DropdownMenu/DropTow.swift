//
//  DropTow.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 28.12.2023.
//

import SwiftUI

struct DropTow: View {
    @State var isShow: Bool = false
    @State var name: String = "Item 1"
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(drop.indices, id: \.self) { item in
                                if item != 0 {
                                    Rectangle().frame(height: 1)
                                        .foregroundStyle(.gray)
                                }
                                Button {
                                    withAnimation {
                                        name = drop[item].title
                                        isShow.toggle()
                                    }
                                } label: {
                                    Text(drop[item].title)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundStyle(.gray)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 20)
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.gray)
                }
                .frame(height: isShow ? 240 : 48)
                .offset(y: isShow ? 0 : -133)
                .foregroundStyle(.red)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 24).frame(height: 48)
                        .foregroundStyle(.ultraThinMaterial)
                    HStack {
                        Text(name)
                            .font(.title2)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.title2)
                            .rotationEffect(.degrees(isShow ? -180 : 0))
                    }
                    .bold()
                    .padding(.horizontal)
                    .foregroundStyle(.black)
                    RoundedRectangle(cornerRadius: 24).stroke(lineWidth: 1).frame(height: 48)
                }
                .offset(y: -133)
                .onTapGesture {
                    withAnimation {
                        isShow.toggle()
                    }
                }
            }
        }
//        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .frame(height: .infinity).offset(y: 40)
    }
}

#Preview {
    DropTow()
}
