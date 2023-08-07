import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack {
            Image("pharaoh")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 120, height: 120)
                .cornerRadius(120 / 2)
                .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
            
            Text("Tutankhamon")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            
            Text("@tutan")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("The relief depicts a child in the arms")
                .font(.system(size: 14))
                .padding(.top, 8)
            
            HStack(spacing: 40) {
                VStack {
                    Text("12")
                        .font(.system(size: 16)).bold()
                    
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                VStack {
                    Text("12")
                        .font(.system(size: 16)).bold()
                    
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
