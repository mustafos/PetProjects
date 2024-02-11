//
//  MonolithDropdown.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 01.02.2024.
//

import SwiftUI

struct MonolithDropdown: View {
    @State var selection1: String? = nil
    
    var body: some View {
        DropDownPicker(
            selection: $selection1,
            options: [
                "Apple", "Google", "Amazon", "Facebook",
                "Instagram", "Netflix", "Meta", "Tesla"
            ]
        )
        .padding(.bottom, 300)
    }
}

#Preview {
    MonolithDropdown()
}

enum DropDownPickerState {
    case up
    case down
}

struct DropDownPicker: View {
    
    @Binding var selection: String?
    var state: DropDownPickerState = .down
    var options: [String]
    
    @State var showDropdown = false
    
    @SceneStorage("drop_down_zindex") private var index = 100.0
    @State var zindex = 100.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if state == .up && showDropdown {
                    ScrollView {
                        OptionsView()
                    }
                    .frame(maxHeight: geometry.size.height - 48)
                }
                
                HStack {
                    Text(selection == nil ? options.first! : selection!)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: state == .up ? "chevron.up" : "chevron.down")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                }
                .padding(.horizontal, 20)
                .frame(width: .infinity, height: 48, alignment: .center)
                .background(.green)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zindex = index
                    withAnimation(.snappy) {
                        showDropdown.toggle()
                    }
                }
                .zIndex(10)
                
                if state == .down && showDropdown {
                    OptionsView()
                }
            }
            .clipped()
            .background(.yellow)
            .cornerRadius(24)
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.gray)
            }
            .frame(height: 240, alignment: state == .up ? .bottom : .top)
            
        }
        .background(.red)
        .frame(width: .infinity, height: 48)
        .zIndex(zindex)
    }
    
    
    func OptionsView() -> some View {
        ScrollView {
            VStack {
                ForEach(options, id: \.self) { option in
                    if selection != option {
                        HStack {
                            Text(option)
                            Spacer()
                            Image(systemName: "star.fill")
                                .foregroundStyle(.black)
                                .opacity(option == "Meta" ? 1 : 0)
                        }
                        .foregroundStyle(Color.gray)
                        .animation(.none, value: selection)
                        .frame(height: 48)
                        .contentShape(.rect)
                        .padding(.horizontal, 20)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.black) // Change the color as needed
                                .padding(.horizontal, 20)
                                .padding(.bottom, 60)
                        )
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selection = option
                                showDropdown.toggle()
                            }
                        }
                    }
                }
            }
            .transition(.move(edge: state == .up ? .bottom : .top))
            .zIndex(1)
        }
    }
}
