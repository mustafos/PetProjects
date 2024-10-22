//
//  CountysView.swift
//  vpn_app
//
//  Created by Mustafa Bekirov on 04.09.2024.
//

import SwiftUI

struct CountysView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CountryViewModel
    
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
                    
                    Text("Select Country")
                        .font(.title3).fontWeight(.semibold).foregroundStyle(.white)
                    
                    Spacer()
                    
                }.padding(.bottom)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.white)
                    
                    TextField("Search Server", text: $viewModel.searchText)
                        .foregroundStyle(Color.gray)
                    
                    if !viewModel.searchText.isEmpty {
                        Button {
                            withAnimation {
                                HapticFeedback.playSelection()
                                viewModel.searchText = ""
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: viewModel.filteredCountries.isEmpty
                           ? .center : .leading) {
                        Text(viewModel.filteredCountries.isEmpty
                             ? "No servers found"
                             : "Choose your plan")
                        .font(.title2).fontWeight(.medium).foregroundStyle(.white)
                        .padding(.top, viewModel.filteredCountries.isEmpty ? 40 : 0)
                        
                        ForEach(viewModel.filteredCountries) { country in
                            Button {
                                withAnimation {
                                    HapticFeedback.playSelection()
                                    viewModel.selectedCountry = country
                                    dismiss()
                                }
                            } label: {
                                customGridService(flag: country.flagImageName.rawValue, name: country.name.rawValue, isSelected: viewModel.selectedCountry?.id == country.id)
                            }
                        }
                    }
                }
            }.padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func customGridService(flag: String, name: String, isSelected: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.black.opacity(0.2))
            
            HStack {
                Image(flag)
                    .resizable().scaledToFit().frame(width: 38)
                
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: isSelected ? "heart.fill" : "heart")
            }
            .padding()
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    CountysView()
}
