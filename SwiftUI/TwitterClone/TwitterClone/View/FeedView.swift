import SwiftUI

struct FeedView: View {
    @State private var isShowingNewTweetView: Bool = false
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.tweets) { tweet in
                        NavigationLink {
                            TweetDetailView(tweet: tweet)
                        } label: {
                            TweetCell(tweet: tweet)
                        }
                    }
                }
                .padding()
            }
            
            Button {
                isShowingNewTweetView.toggle()
            } label: {
                Image("Tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $isShowingNewTweetView) {
                NewTweetView(isPresented: $isShowingNewTweetView)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
