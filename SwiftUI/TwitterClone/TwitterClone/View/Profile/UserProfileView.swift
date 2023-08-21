import SwiftUI

struct UserProfileView: View {
    let user: User
//    @ObservedObject var viewModel: ProfileViewModel
    @State private var selectedFilter: TweetFilterOptions = .tweets

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(user: user)
                    .padding()
                
                FilterButtonView(selectedOption: $selectedFilter)
                    .padding()
                
                ForEach(0..<9) { tweet in
                    TweetCell()
                }
                .padding()
            }
            .navigationTitle("pharaon")
        }
    }
}
