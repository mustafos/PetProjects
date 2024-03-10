//
//  ExpandableView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 10.03.2024.
//

import SwiftUI

struct ExpandableView: View {
    @Namespace private var namespace
    @State private var show = false
    
    var thumbnail: ThumbnailView
    var expandeed: ExpandedView
    
    var body: some View {
        ZStack {
            if !show {
                thumbnailView()
            } else {
                expandedView()
            }
        }
        .onTapGesture {
            if !show {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    show.toggle()
                }
            }
        }
    }
    
    @ViewBuilder
    private func thumbnailView() -> some View {
        ZStack {
            thumbnail
                .matchedGeometryEffect(id: "veiw", in: namespace)
        }
        .background(
            Color.gray
                .opacity(0.7)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
    }
    
    @ViewBuilder
    private func expandedView() -> some View {
        ZStack {
            expandeed
                .matchedGeometryEffect(id: "view", in: namespace)
                .background(
                    Color.black
                        .matchedGeometryEffect(id: "background", in: namespace)
                )
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                }
            
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    show.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .matchedGeometryEffect(id: "mask", in: namespace)
        }
    }
}

#Preview {
    ExpandableView(
        thumbnail:
                    ThumbnailView(content: {
                        VStack {
                            Text("The art of war")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(MadimiOneFont(isBold: true, size: 20))
                            
                            Text("Reading time: 3 mins")
                                .font(MadimiOneFont(size: 8))
                                .foregroundStyle(.white)
                        }
                        .padding()
    }), expandeed: ExpandedView(content: {
        VStack {
            Text("The art of war")
                .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white)
                    .font(MadimiOneFont(isBold: true, size: 28))
            Text("Reading time: 3 mins")
                .font(MadimiOneFont(size: 14))
                .foregroundStyle(.white)
            
            Text("""
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Pellentesque pretium lectus id turpis. Nullam faucibus mi quis velit. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Etiam ligula pede, sagittis quis, interdum ultricies, scelerisque eu. Mauris metus. Integer tempor. Maecenas fermentum, sem in pharetra pellentesque, velit turpis volutpat ante, in pharetra metus odio a lectus. Fusce suscipit libero eget elit. Maecenas lorem. Etiam egestas wisi a erat. Aenean id metus id velit ullamcorper pulvinar. Nullam sapien sem, ornare ac, nonummy non, lobortis a enim. Integer rutrum, orci vestibulum ullamcorper ultricies, lacus quam ultricies odio, vitae placerat pede sem sit amet enim. Curabitur sagittis hendrerit ante.
""")
            .font(MadimiOneFont(size: 14))
            .foregroundStyle(.white)
            
            Spacer()
        }
        .padding()
        }))
}
