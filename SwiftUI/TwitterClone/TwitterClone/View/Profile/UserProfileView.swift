import SwiftUI

struct UserProfileView: View {
//    let user: User
//    @ObservedObject var viewModel: ProfileViewModel
    @State private var selectedFilter: TweetFilterOptions = .tweets
    
//    init(user: User, selectedFilter: TweetFilterOptions) {
//        self.user = user
//        self.selectedFilter = selectedFilter
//    }
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView()
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

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
