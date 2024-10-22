//
//  HomeView.swift
//  vpn_app
//
//  Created by Mustafa Bekirov on 04.09.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: CountryViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hello \(viewModel.userName),")
                                .font(.footnote).fontWeight(.light).foregroundStyle(.gray)
                                .onTapGesture {
                                    viewModel.isPresentAddName.toggle()
                                }
                            Text("Welcome Back!")
                                .font(.title3).fontWeight(.semibold).foregroundStyle(.white)
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            PremiumView()
                        } label: {
                            Image("crown")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("Color1"))
                        }
                    }.padding(.horizontal)
                    
                    location()
                    
                    customGrid()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.black.opacity(0.2))
                            .frame(maxHeight: .infinity)
                            .offset(y: 35)
                        
                        VStack {
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(.black.opacity(0.2))
                                    .frame(width: 180, height: 40)
                                
                                HStack {
                                    Image("crown").resizable().renderingMode(.template).scaledToFit().frame(width: 20, height: 20).foregroundColor(Color("Color1"))
                                    
                                    Text("Go to premium").font(.subheadline).fontWeight(.regular).foregroundStyle(Color("Color1"))
                                }
                            }.padding(.bottom)
                            
                            Spacer().frame(height: 60)
                            
                            Text("Connection Time")
                                .font(.footnote)
                                .fontWeight(.light)
                                .foregroundStyle(.gray)
                            
                            Text(viewModel.elapsedTime)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Button {
                                withAnimation(.snappy) {
                                    HapticFeedback.playSelection()
                                    viewModel.toggleConnection()
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.black.opacity(0.2))
                                        .frame(width: 120, height: 120)
                                    
                                    Circle()
                                        .fill(viewModel.isConnected ? .green : .clear)
                                        .frame(width: viewModel.isConnected ? 120 : 0,
                                               height: viewModel.isConnected ? 120 : 0)
                                    
                                    Image(systemName: "power")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(viewModel.isConnected ? .white : Color("Color1"))
                                        .fontWeight(.bold)
                                }
                            }.buttonStyle(.plain).padding(.top, 25)
                            
                            Spacer()
                            
                        }
                        
                    }
                    
                }
                .alert("Edit Your Name", isPresented: $viewModel.isPresentAddName) {
                    TextField("Your name", text: $viewModel.userName)
                    Button("Save", action: {
                        viewModel.isPresentAddName.toggle()
                    })
                } message: {
                    Text("Please Enter your name to edit.")
                }
                .onAppear {
                    if viewModel.userName.isEmpty {
                        viewModel.isPresentAddName.toggle()
                    }
                }
            }
        }
    }
    
    func location() -> some View {
        NavigationLink {
            CountysView().environmentObject(viewModel)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.black.opacity(0.2))
                    .frame(height: 80)
                
                if let selectedCountry = viewModel.selectedCountry {
                    HStack(spacing: 20) {
                        Image(selectedCountry.flagImageName.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(selectedCountry.name.rawValue)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            Text(viewModel.userIPAddress).font(.footnote).fontWeight(.light).foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right").resizable().scaledToFit().frame(width: 15, height: 15).foregroundColor(.gray)
                        
                    }.padding(.horizontal)
                }
            }.padding(.horizontal)
        }
    }
    
    func customGrid() -> some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.black.opacity(0.2))
                    .frame(height: 80)
                HStack {
                    Image(systemName: "arrow.down.circle").imageScale(.large).foregroundColor(.green).rotationEffect(.degrees(45))
                    
                    VStack(alignment: .leading) {
                        Text("Download").font(.footnote).fontWeight(.light).foregroundStyle(.gray)
                        Text("145 Mbit/s").font(.title3).fontWeight(.semibold).foregroundStyle(.white)
                    }
                }
            }
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.black.opacity(0.2))
                    .frame(height: 80)
                HStack {
                    Image(systemName: "arrow.up.circle").imageScale(.large).foregroundColor(.red).rotationEffect(.degrees(45))
                    
                    VStack(alignment: .leading) {
                        Text("Upload").font(.footnote).fontWeight(.light).foregroundStyle(.gray)
                        Text("90 Mbit/s").font(.title3).fontWeight(.semibold).foregroundStyle(.white)
                    }
                }
            }
        }.padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
