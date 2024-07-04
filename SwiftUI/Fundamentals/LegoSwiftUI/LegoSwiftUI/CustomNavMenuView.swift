//
//  CustomNavMenuView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 04.07.2024.
//

import SwiftUI

struct CustomNavMenuView: View {
    var body: some View {
        Home()
    }
}

#Preview {
    CustomNavMenuView()
}

struct Home: View {
    @State private var index: Int = 0
    @State private var show: Bool = false
    var body: some View {
        ZStack {
            
            // Menu...
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: "car")
                    
                    Text("Hey")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.top, 10)
                    
                    Text("Norman")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    Button {
                        withAnimation {
                            self.index = 0
                            self.show.toggle()
                        }
                    } label: {
                        CustomButton(image: "mic", title: "Menu", index: 0)
                    }.padding(.top, 25)
                    
                    Button {
                        withAnimation {
                            self.index = 1
                            self.show.toggle()
                        }
                    } label: {
                        CustomButton(image: "bolt.horizontal", title: "Message", index: 1)
                    }
                    
                    Button {
                        withAnimation {
                            self.index = 2
                            self.show.toggle()
                        }
                    } label: {
                        CustomButton(image: "network", title: "Network", index: 2)
                    }
                    
                    Button {
                        withAnimation {
                            self.index = 3
                            self.show.toggle()
                        }
                    } label: {
                        CustomButton(image: "figure.wave", title: "Person", index: 3)
                    }
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .background(Color.white)
                        .padding(.vertical, 30)
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "figure.walk.arrival")
                                .foregroundStyle(Color.white)
                            
                            Text("Log Out")
                                .foregroundStyle(Color.white)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 25)
                .padding(.horizontal)
                
                Spacer(minLength: 0)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
            // MainView...
            
            VStack(spacing: 0) {
                HStack(spacing: 15) {
                    Button {
                        withAnimation {
                            self.show.toggle()
                        }
                    } label: {
                        Image(systemName: show ? "xmark" : "line.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                            .foregroundColor (Color.black.opacity(0.4))
                    }
                    
                    // Changing Name Based On Index...
                    Text(self.index == 0 ? "Home" : (self.index == 1 ? "Cart" : (self.index == 2 ? "Favourites" : "Orders")))
                        .font(.title)
                        .foregroundColor(Color.black.opacity(0.6))
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()
                
                GeometryReader {_ in
                    VStack {
                        if self.index == 0 {
                            MainPage()
                        } else if index == 1 {
                            Cart()
                        } else if index == 2 {
                            Favourites()
                        } else {
                            Orders()
                        }
                    }
                }
            }
            .background(Color.white)
            //Applying corner radius...
            .cornerRadius(self.show ? 30 : 0)
            // MARK: shrinking and moving view right side when menu button is clicked...
            .scaleEffect(self.show ? 0.9 : 1)
            .offset(x: self.show ? UIScreen.main.bounds.width / 1.4 : 0, y: self.show ? 100 : 0)
            // Rotating Slighly...
            .rotationEffect(.init(degrees: self.show ? -10 : 0))
        }
        .background(Color.brown.ignoresSafeArea())
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func CustomButton(image: String, title: String, index: Int) -> some View {
        HStack(spacing: 25) {
            Image(systemName: image)
                .foregroundStyle(self.index == index ? Color.red : Color.white)
            
            Text(title)
                .foregroundStyle(self.index == index ? Color.red : Color.white)
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(self.index == index ? Color.red.opacity(0.2) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: – Mainpage View
struct MainPage: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 12) {
                Image(systemName: "arcade.stick.console")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 210)
                
                Text("Game Console")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .padding(.top, 10)
                
                Text("Your choice to better life")
                    .foregroundStyle(.gray)
            }
            .padding()
            .background(Color.black.opacity(0.06))
            .cornerRadius(15)
            .padding()
            
            Button {
                
            } label: {
                Image(systemName: "cart")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.pink)
                    .contrast(15)
            }
            .padding(.trailing)
        }
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                AdditionalProduct(image: "scanner", title: "iScanner", subtitle: "All documents in your pocket")
                AdditionalProduct(image: "display", title: "iMac", subtitle: "New habbits for your eye")
                AdditionalProduct(image: "server.rack", title: "iServer", subtitle: "Only this thing to hack your friends")
            }.padding()
        }
    }
    
    @ViewBuilder
    func AdditionalProduct(image: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                Text(subtitle)
                    .foregroundStyle(.gray)
            }
            
            Spacer(minLength: 0)
        }
    }
}

// MARK: – All Other Views...
struct Cart: View {
    var body: some View {
        VStack {
            Text("Cart I")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }.background(Color.cyan.opacity(0.3).gradient)
    }
}

struct Orders: View {
    var body: some View {
        VStack {
            Text("Orders II")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }.background(Color.indigo.opacity(0.3).gradient)
    }
}

struct Favourites: View {
    var body: some View {
        VStack {
            Text("Favourites III")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }.background(Color.mint.opacity(0.3).gradient)
    }
}
