import SwiftUI

struct TweetActionsView: View {
    
    let tweet: Tweet
    
    @ObservedObject var viewModel: TweetActionViewModel
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.viewModel = TweetActionViewModel(tweet: tweet)
    }
    
    var body: some View {
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
                viewModel.didLike ? viewModel.unlikeTweet() : viewModel.likeTweet()
            } label: {
                Image(systemName: viewModel.didLike ? "heart.fill" : "heart")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
                    .foregroundColor(.red)
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
    }
}
