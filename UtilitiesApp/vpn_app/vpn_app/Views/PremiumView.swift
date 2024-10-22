//
//  PremiumView.swift
//  vpn_app
//
//  Created by Mustafa Bekirov on 04.09.2024.
//

import SwiftUI

struct PremiumView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isPurchased") var isPurchased = false
    private var priceTitle = ["1 Month", "3 Month", "6 Month"]
    private var price = ["$9.00", "$19.99", "$29.99"]
    private var priceSubtitle = ["Billed Montly", "Save 20%", "Save 30%"]
    @State var selectedTier = 0
    var body: some View {
            ZStack {
                Color("background").ignoresSafeArea()
                VStack {
                    HStack {
                        Image(systemName: "chevron.left").imageScale(.large).fontWeight(.semibold).foregroundColor(.white)
                            .onTapGesture {
                                dismiss()
                            }
                        Spacer()
                        
                        Text("Upgrade To Premium").font(.title3).fontWeight(.semibold).foregroundStyle(.white)
                        
                        Spacer()
                    }.padding(.bottom)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.black.opacity(0.2))
                                .frame(height: 150)
                            
                            VStack {
                                Image(systemName: "crown.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.yellow)
                                    .frame(width: 25, height: 25)
                                    .background(
                                    Circle()
                                        .fill(Color.yellow.opacity(0.2))
                                        .frame(width: 50, height: 50)
                                    ).padding(.bottom)
                                
                                Text("Go To Premium").font(.title2).fontWeight(.semibold).foregroundStyle(Color("Color1"))
                                
                                Text("Get full app access without restrictions, ads, and unlock all Servers!").font(.footnote).fontWeight(.regular).foregroundColor(.gray).multilineTextAlignment(.center)
                            }
                        }.frame(maxHeight: 150)
                        
                        HStack {
                            customGridPremium(systemSymbol: "lock.circle.fill", title: "Private", subtitle: "Connection")
                            customGridPremium(systemSymbol: "map.fill", title: "Unlock All", subtitle: "Servers")
                        }.padding(.top, 5)
                        
                        HStack {
                            customGridPremium(systemSymbol: "bolt.fill", title: "Faster Than", subtitle: "Before")
                            customGridPremium(systemSymbol: "heart.fill", title: "No Annoying", subtitle: "Ads")
                        }
                        
                        VStack {
                            Text("Choose your plan").font(.title2).fontWeight(.medium).foregroundStyle(.white)
                            
                            ForEach(price.indices, id: \.self) { items in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.gray, lineWidth: 2)
                                        .frame(height: 70)
                                    
                                    HStack {
                                        ZStack {
                                            Image(systemName: selectedTier == items ? "checkmark.circle.fill" : "").imageScale(.large).foregroundColor(Color("Color2"))
                                            Circle()
                                                .stroke(.white, lineWidth: 2)
                                                .frame(width: 25, height: 25)
                                        }
                                        
                                        Text(priceTitle[items]).font(.title3).fontWeight(.bold).foregroundStyle(.white)
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing) {
                                            Text(price[items]).font(.title3).fontWeight(.semibold).foregroundStyle(Color("Color1"))
                                            Text(priceSubtitle[items]).font(.footnote).fontWeight(.regular).foregroundStyle(.gray)
                                        }
                                        
                                    }.padding(.horizontal)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        selectedTier = items
                                    }
                                }
                            }
                            
                        }.padding([.top, .bottom], 5)
                        
                        Button {
                            HapticFeedback.playSelection()
                            isPurchased.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                dismiss()
                            }
                        } label: {
                            Text("Unlock Premium").font(.title3).fontWeight(.regular).foregroundStyle(.white).frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 50)
                                        .fill(Color("Color1"))
                                        .frame(height: 60)
                                }
                            
                        }.padding(.top, 25).buttonStyle(.plain)
                    }
                }.padding(.horizontal)
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct customGridPremium: View {
    var systemSymbol: String
    var title: String
    var subtitle: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.black.opacity(0.2))
                .frame(height: 80)
            HStack {
                Image(systemName: systemSymbol).imageScale(.large).foregroundColor(Color("Color2"))
                
                VStack(alignment: .leading) {
                    Text(title).font(.title3).fontWeight(.light).foregroundStyle(.gray).lineLimit(1).minimumScaleFactor(0.5)
                    Text(subtitle).font(.title3).fontWeight(.semibold).foregroundStyle(.white).frame(maxWidth: .infinity, alignment: .leading).lineLimit(1).minimumScaleFactor(0.5)
                }
                
            }.padding(.horizontal)
        }
    }
}

#Preview {
    PremiumView()
}
