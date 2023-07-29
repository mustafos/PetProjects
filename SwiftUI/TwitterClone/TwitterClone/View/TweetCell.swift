import SwiftUI

struct TweetCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image("pharaoh")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(56 / 2)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Tutankhamun")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text("@tutank ∘")
                            .foregroundColor(.gray)
                        
                        Text("2w")
                            .foregroundColor(.gray)
                    }
                    
                    Text("Lorem ipsum dolor sit amet, sed do eiusmod tempor incididunt.")
                }
            }
            .padding(.bottom)
            .padding(.trailing)
            
            HStack {
                Button {
                    print("Button")
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                }
                
                Spacer()
                
                Button {
                    print("Button")
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                }
                
                Spacer()
                
                Button {
                    print("Button")
                } label: {
                    Image(systemName: "heart")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                }
                
                Spacer()
                
                Button {
                    print("Button")
                } label: {
                    Image(systemName: "bookmark")
                        .font(.system(size: 16))
                        .frame(width: 32, height: 32)
                }
            }
            .foregroundColor(.gray)
            .padding(.horizontal)
            
            Divider()
        }
    }
}

struct TweetCell_Previews: PreviewProvider {
    static var previews: some View {
        TweetCell()
    }
}
