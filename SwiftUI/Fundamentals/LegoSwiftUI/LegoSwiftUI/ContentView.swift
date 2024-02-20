//
//  ContentView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 11.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var presentSideMenu: Bool = false
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                OTPTextView { value in
                    print(value)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .top) {
                ZStack {
                    HStack {
                        Button {
                            presentSideMenu.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 24, height: 24)
                        .padding(.leading, 30)
                        
                        CategoryView(categories: categoriesData) { value in
                            print(value)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(.white)
                .zIndex(1)
                .shadow(radius: 0.5)
            }
            .background(.gray.opacity(0.8))
            
            SideMenu()
        }
        .frame(maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func SideMenu() -> some View {
        SideMenuView(isShowing: $presentSideMenu, direction: .leading) {
            SideViewContents(presentSideMenu: $presentSideMenu)
                .frame(width: 300)
        }
    }
}

#Preview {
    ContentView()
}
