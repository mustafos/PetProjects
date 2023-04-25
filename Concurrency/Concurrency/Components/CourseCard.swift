import SwiftUI

struct CourseCard: View {
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: "https://miro.medium.com/v2/resize:fit:4800/format:webp/1*51_88da7J-O4MoHtatOnvg.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 128, alignment: .center)
                
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
            }
            
            Spacer()
            
            Text("SwiftUI for iOS 15")
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            Text("20 sections - 4 hours")
                .font(.caption)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
        }
        .padding(16)
        .frame(height: 217, alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                    .blendMode(.overlay))
    }
}

struct CourseCard_Previews: PreviewProvider {
    static var previews: some View {
        CourseCard()
    }
}

