//
//  NotificationsView.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 04.04.2023.
//

import SwiftUI

struct NotificationsView: View {
    @State var contentHasScrolled = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            content
                .background(Image("Blob 1").offset(x: -180, y: 300))
        }
    }
    
    var content: some View {
        ScrollView {
            scrollDetection
            
            sectionsSection
                .padding(.vertical, 70)
                .padding(.bottom, 50)
        }
        .coordinateSpace(name: "scroll")
        .overlay(NavigationBar(title: "Notifications", contentHasScrolled: $contentHasScrolled))
    }
    
    var sectionsSection: some View {
        VStack(spacing: 16) {
            ForEach(Array(courseSections.enumerated()), id: \.offset) { index, section in
                SectionRow(section: section)
                if index != courseSections.count - 1 {
                    Divider()
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { offset in
            withAnimation(.easeInOut) {
                if offset < 0 {
                    contentHasScrolled = true
                } else {
                    contentHasScrolled = false
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
            .environmentObject(Model())
    }
}

