//
//  CustomScrollView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 09.11.2023.
//

import SwiftUI

import SwiftUI

struct ScrollPreKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct CustomScrollView: View {
    @State var isScroll = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            getScrollOffsetReader()
            CardsView()
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollPreKey.self, perform: { value in
            updateScrollStatus(value: value)
        })
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 30)
        })
        .overlay {
            VanBarView(isScroll: $isScroll)
        }
    }
    
    func getScrollOffsetReader() -> some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
    }
    
    func updateScrollStatus(value: CGFloat) {
        withAnimation(.default) {
            isScroll = value < 0
        }
    }
}

struct CardsView: View {
    var body: some View {
        ForEach(0 ..< 5) { item in
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .foregroundColor(.indigo)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 10)
                .padding()
                .overlay {
                    VStack(alignment: .leading) {
                        Circle()
                            .frame(width: 50, height: 50)
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .frame(width: 100, height: 25)
                        VStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .frame(width: 250, height: 15)
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .frame(width: 200, height: 15)
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .frame(width: 290, height: 15)
                        }
                        .padding(.top)
                    }
                }
        }
    }
}

struct VanBarView: View {
    @Binding var isScroll: Bool
    var body: some View {
        ZStack {
            Color.clear
                .frame(height: isScroll ? 90 : 100)
                .background(.ultraThinMaterial)
                .opacity(isScroll ? 1 : 0)
                .blur(radius: 0.5)
                .ignoresSafeArea()
            HStack {
                Text("Záznamy")
                    .font(isScroll ? .title3 : .largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "trophy")
                    .font(isScroll ? .title : .largeTitle)
                    .padding(.bottom, 10)
            }
            .offset(y: isScroll ? -30 : -25)
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    CustomScrollView()
}
