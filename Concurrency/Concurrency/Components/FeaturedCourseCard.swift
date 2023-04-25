import SwiftUI

struct FeaturedCourseCard: View {
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: "https://miro.medium.com/v2/resize:fit:4800/format:webp/1*51_88da7J-O4MoHtatOnvg.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 220, alignment: .center)

            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
            }
            
            Spacer()
            
            Text("SwiftUI Combine and Data")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Text("18 sections - 3 hours")
                .font(.footnote)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .multilineTextAlignment(.leading)

            Text("Learn about Combine, the MVVM architecture, data, notifications and performance hands-on by creating a beautiful SwiftUI app")
                .font(.footnote)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

        }
        .padding(16)
        .frame(width: 252, height: 350, alignment: .top)
        .background()
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                .blendMode(.overlay))

    }
    
}

struct FeaturedChapterCard_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCourseCard()
    }
}
