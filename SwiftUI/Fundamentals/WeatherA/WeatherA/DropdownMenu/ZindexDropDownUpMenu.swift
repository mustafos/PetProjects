//
//  ZindexDropDownUpMenu.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 02.05.2024.
//

import SwiftUI

struct ZindexDropDownUpMenu: View {
    @State private var selection: String?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Button("Click Me") {}
                DropDownUpView(hint: "Select", options: ["Female", "Male", "Other"], anchor: .bottom, selection: $selection)
                DropDownUpView(hint: "Select", options: ["One", "Two", "Three"], anchor: .bottom, selection: $selection)
                DropDownUpView(hint: "Select", options: ["Red", "Green", "Blue"], anchor: .top, selection: $selection)
                Button("Click Me") {}
            }.navigationTitle("Dropdown Picker")
        }
    }
}

#Preview {
    ZindexDropDownUpMenu()
}

struct DropDownUpView: View {
    var hint: String
    var options: [String]
    var anchor: Anchor = .bottom
    var maxWidth: CGFloat = 150
    @Binding var selection: String?
    @State private var showOptions: Bool = false
    @Environment(\.colorScheme) private var sheme
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zIndex: Double = 1000.0
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                if showOptions && anchor == .top {
                    OptionView()
                }
                
                HStack(spacing: 0) {
                    Text(selection ?? hint)
                        .foregroundStyle(selection == nil ? .gray : .primary)
                        .lineLimit(1)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .rotationEffect(.init(degrees: showOptions ? -180 : 0))
                }
                .padding(.horizontal, 15)
                .frame(width: size.width, height: size.height)
                .background(sheme == .dark ? .black : .white)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zIndex = index
                    withAnimation(.snappy) {
                        showOptions.toggle()
                    }
                }
                .zIndex(10)
                
                if showOptions && anchor == .bottom {
                    OptionView()
                }
            }
            .clipped()
            .contentShape(.rect)
            .background((sheme == .dark ? Color.black : Color.white)
                .shadow(.drop(color: .primary.opacity(0.15), radius: 4)),
                        in: .rect(cornerRadius: 12))
            .frame(height: size.height, alignment: anchor == .top ? .bottom : .top)
        }
        .frame(width: maxWidth, height: 50)
        .zIndex(zIndex)
    }
    
    @ViewBuilder
    func OptionView() -> some View {
        VStack(spacing: 10) {
            ForEach(options, id: \.self) { option in
                HStack(spacing: 0) {
                    Text(option)
                        .lineLimit(1)
                    Spacer(minLength: 0)
                    Image(systemName: "checkmark")
                        .font(.caption)
                        .opacity(selection == option ? 1 : 0)
                }
                .foregroundStyle(selection == option ? Color.primary : Color.gray)
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        showOptions = false
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5) //+
        .transition(.move(edge: anchor == .top ? .bottom : .top))
    }
    
    enum Anchor {
        case top
        case bottom
    }
}
