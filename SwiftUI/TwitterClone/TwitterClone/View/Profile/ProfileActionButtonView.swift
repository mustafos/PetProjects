import SwiftUI

struct ProfileActionButtonView: View {
    let isCurrentUser: Bool
    var body: some View {
        if isCurrentUser {
            Button {
                print("edit profile")
            } label: {
                Text("Edit Profile")
                    .frame(width: 360, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            .cornerRadius(20)
        } else {
            HStack {
                Button {
                    print("follow")
                } label: {
                    Text("Follow")
                        .frame(width: 180, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                }
                .cornerRadius(20)
                
                Button {
                    print("message")
                } label: {
                    Text("Message")
                        .frame(width: 180, height: 40)
                        .background(Color.purple)
                        .foregroundColor(.white)
                }
                .cornerRadius(20)
            }
        }
    }
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView(isCurrentUser: false)
    }
}
