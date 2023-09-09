import SwiftUI

struct UserProfileView: View {
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(isFollowed: $viewModel.isFollowed, viewModel: viewModel)
                    .padding()
                
                ForEach(viewModel.userTweets) { tweet in
                    TweetCell(tweet: tweet)
                        .padding()
                }
            }
            .navigationTitle("pharaon")
        }
    }
}
