//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Mustafa Bekirov on 07.10.2023.
//

import SwiftUI

enum TabBar: String, CaseIterable {
    case figure
    case house
    case person
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabBar
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    private var tabColor: Color {
        switch selectedTab {
            case .figure:
                return .red
            case .house:
                return .yellow
            case .person:
                return .green
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(TabBar.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? tabColor : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, maxHeight: 76)
            .background(.ultraThinMaterial)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.house))
}
