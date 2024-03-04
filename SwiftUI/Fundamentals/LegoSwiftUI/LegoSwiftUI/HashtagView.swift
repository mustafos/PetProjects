//
//  HashtagView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 11.02.2024.
//

import SwiftUI

let hashtags = ["#AdventureTime", "#ExploreMore", "#CreativityUnleashed",
                        "#WildAndFree", "#InnovationNation", "#DreamBig",
                        "#Wanderlust", "#MindfulnessJourney", "#TechTrends",
                        "#ArtisticVision", "#HealthyLiving", "#SelfCareSunday",
                        "#FoodieFinds", "#TravelGoals", "#FitnessMotivation",
                        "#BookWorm", "#DIYProjects", "#FashionForward"]

// MARK: This is tutorial from our previous video. Link in the description.

struct HashtagView: View {
    @State private var viewHeight = CGFloat.zero
    var tags: [String]
    var action: (String) -> ()
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        self.generateHashtagViews(g: geometry)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func generateHashtagViews(g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.HashtagTextView(text: tag)
                    .padding([.leading, .vertical], 4)
                    .alignmentGuide(.leading) { dimension in
                        if(abs(width - dimension.width) > g.size.width) {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { dimension in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0
                        }
                        return result
                    }
            }
        }
        .background(getViewHeight($viewHeight))
    }
    
    @ViewBuilder
    private func HashtagTextView(text: String) -> some View {
        Button {
            action(text)
        } label: {
            HStack(alignment: .top) {
                Text(text)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .bold()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(.secondary)
            .cornerRadius(30)
        }
    }
    // Need to get height of the view
    private func getViewHeight(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            let rect = geo.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview {
    HashtagView(tags: hashtags) { tag in
        print(tag)
    }
}
