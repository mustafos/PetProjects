//
//  TabViewEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 12.05.2023.
//

import SwiftUI

struct TabViewEx: View {
    
    @State var tabSelected = 1
    
    var body: some View {
        TabView(selection: $tabSelected) {
            HomeView(tabSelection: $tabSelected)
                .badge(42)
                .tabItem {
                    Label("Received", systemImage: "tray.and.arrow.down.fill")
                }
                .tag(0)
            ZStack {
                Text("SentView")
            }
            .tabItem {
                Label("Sent", systemImage: "tray.and.arrow.up.fill")
            }
            .tag(1)
            Text("AccountView")
                .badge("!")
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
                .tag(2)
        }
        .font(.headline)
        .accentColor(.blue)
    }
}

struct TabViewEx_Previews: PreviewProvider {
    static var previews: some View {
        TabViewEx()
    }
}

struct HomeView: View {
    
    @Binding var tabSelection: Int
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea(edges: .top)
            VStack {
                Text("ReceivedView")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Button {
                    tabSelection = 2
                } label: {
                    Text("Go to bin")
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
