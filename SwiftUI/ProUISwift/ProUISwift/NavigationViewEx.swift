//
//  NavigationViewEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 11.05.2023.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userBuy: UserBuy
    var text: String
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Buy \(text) \(userBuy.caps) pieces")
            
                .navigationBarItems(leading: Button("Back to menu") {
                    self.presentation.wrappedValue.dismiss()
                }, trailing: HStack {
                    Button("–") {
                        guard self.userBuy.caps > 0 else { return }
                        self.userBuy.caps -= 1
                    }
                    Button("+") {
                        self.userBuy.caps += 1
                    }
                })
        }
        .navigationBarBackButtonHidden(true)
        
        .onAppear() {
            self.userBuy.caps = 0
        }
    }
}

class UserBuy: ObservableObject {
    @Published var caps = 0
}

struct NavigationViewEx: View {
    @ObservedObject var userBuy = UserBuy()
    
    let coffee = "Coffee"
    let tea = "Tea"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Your choice is \(userBuy.caps) pieces")
                Text("What do you want?")
                
                NavigationLink(destination: DetailView(text: coffee), label: {
                    Text(coffee)
                })
                
                NavigationLink(destination: DetailView(text: tea), label: {
                    Text(tea)
                })
                .navigationTitle("Menu")
            }
        }
        .environmentObject(userBuy)
    }
}

struct NavigationViewEx_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewEx()
    }
}
