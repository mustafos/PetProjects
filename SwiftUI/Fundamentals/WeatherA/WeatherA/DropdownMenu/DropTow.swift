//
//  DropTow.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 27.12.2023.
//

import SwiftUI

struct DropTow: View {
    @State var show: Bool = true
    @State var name: String = "Item 1"
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 17) {
                            ForEach(drop.indices, id: \.self) { item in
                                if item != 0 {
                                    Rectangle().frame(height: 1)
                                        .foregroundStyle(.gray)
                                }
                                Button {
                                    withAnimation {
                                        name = drop[item].title
                                        show.toggle()
                                    }
                                } label: {
                                    Text(drop[item].title)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 15)
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.gray)
                        .padding(1)
                }
                .frame(height: show ? 200 : 50)
                .offset(y: show ? 0 : -135)
                .foregroundStyle(.ultraThinMaterial)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10).frame(height: 60)
                        .foregroundStyle(.white)
                    HStack {
                        Text(name)
                            .font(.title2)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(show ? -180 : 0))
                    }
                    .bold()
                    .padding(.horizontal)
                    .foregroundStyle(.black)
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).frame(height: 60)
                        .padding(1)
                }
                .offset(y: -133)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                    }
                }
            }
        }
        .padding()
        .frame(height: 280).offset(y: 40)
    }
}

#Preview {
    DropTow()
}
