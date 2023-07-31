import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack(spacing: 12) {
            Image("spiderman")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Spiderman")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Piter Parker")
                    .font(.system(size: 14, weight: .semibold))
            }
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
