//
//  BlogViewTypeOne.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 04.03.2024.
//

import SwiftUI

let articleContent: String = """
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Pellentesque pretium lectus id turpis. Nullam faucibus mi quis velit. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Etiam ligula pede, sagittis quis, interdum ultricies, scelerisque eu. Mauris metus. Integer tempor. Maecenas fermentum, sem in pharetra pellentesque, velit turpis volutpat ante, in pharetra metus odio a lectus. Fusce suscipit libero eget elit. Maecenas lorem. Etiam egestas wisi a erat. Aenean id metus id velit ullamcorper pulvinar. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim. Integer rutrum, orci vestibulum ullamcorper ultricies, lacus quam ultricies odio, vitae placerat pede sem sit amet enim. Curabitur sagittis hendrerit ante.

Mauris elementum mauris vitae tortor. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Phasellus faucibus molestie nisl. Praesent dapibus. Praesent in mauris eu tortor porttitor accumsan. Nam sed tellus id magna elementum tincidunt. Nulla accumsan, elit sit amet varius semper, nulla mauris mollis quam, tempor suscipit diam nulla vel leo. Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Phasellus enim erat, vestibulum vel, aliquam a, posuere eu, velit. Fusce consectetuer risus a nunc. Vivamus luctus egestas leo. Nunc auctor. Aenean id metus id velit ullamcorper pulvinar. Fusce aliquam vestibulum ipsum. Curabitur sagittis hendrerit ante.

Etiam neque. Phasellus et lorem id felis nonummy placerat. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci. Nullam lectus justo, vulputate eget mollis sed, tempor sed magna. Etiam dictum tincidunt diam. Pellentesque pretium lectus id turpis. Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? Integer malesuada. Suspendisse sagittis ultrices augue. Duis viverra diam non justo. Cras elementum. Pellentesque pretium lectus id turpis. Integer imperdiet lectus quis justo. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nam quis nulla. In rutrum. Aliquam erat volutpat. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est.
"""

struct BlogViewTypeOne: View {
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    HeaderView()
                    ArticleTextView(text: "The art of being an artist", isBold: false, size: 28)
                        .padding(.top, 30)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 3)
                        .opacity(0.2)
                    ArticleTextView(text: "Simplified Products", size: 28)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250, height: 3)
                        .frame(height: 3)
                        .opacity(0.2)
                    ArticleTextView(text: "Tags", isBold: false, size: 18)
                    HashtagView(tags: hashtags) { value in
                        print("Clicked Hashtag: \(value)")
                    }
                    .frame(height: 150)
                    ArticleTextView(text: "Article Content", size: 24)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 3)
                        .opacity(0.2)
                    ArticleTextView(text: articleContent, isBold: false, size: 21)
                }
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            ArticleTextView(text: "New Article", size: 34)
            Spacer()
            Image(systemName: "square.amd.arrow.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func ArticleTextView(text: String, isBold: Bool = true, size: CGFloat) -> some View {
        Text(text)
            .font(MadimiOneFont(isBold: isBold, size: size))
    }
}

#Preview {
    BlogViewTypeOne()
}
