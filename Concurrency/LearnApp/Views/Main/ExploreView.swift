//
//  ExploreView.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 04.04.2023.
//

import SwiftUI

struct ExploreView: View {
    @State var contentHasScrolled = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            content
                .background(Image("Blob 1").offset(x: -100, y: -400))
        }
    }
    
    var content: some View {
        ScrollView {
            scrollDetection
            
            coursesSection
            
            Group {
                Text("Topics".uppercased())
                    .sectionTitleModifier()
                
                topicsSection
                
                Text("Popular".uppercased())
                    .sectionTitleModifier()
                
                handbooksSection
                    .padding(.bottom, 50)
            }
            .offset(y: -50)
        }
        .coordinateSpace(name: "scroll")
        .overlay(NavigationBar(title: "Explore", contentHasScrolled: $contentHasScrolled))
    }
    
    var coursesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(courses) { item in
                    SmallCourseItem(course: item)
                }
            }
            .padding(20)
            .padding(.bottom, 40)
        }
        .padding(.top, 60)
    }
    
    var topicsSection: some View {
        VStack {
            ForEach(Array(topics.enumerated()), id: \.offset) { index, topic in
                ListRow(title: topic.title, icon: topic.icon)
                if index != topics.count - 1 {
                    Divider()
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var handbooksSection: some View {
        HStack(alignment: .top, spacing: 16) {
            ForEach(handbooks) { handbook in
                HandbookItem(handbook: handbook)
            }
        }
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

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .environmentObject(Model())
    }
}
