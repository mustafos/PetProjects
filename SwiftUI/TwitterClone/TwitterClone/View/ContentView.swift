import SwiftUI
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedIndex = 0
    @State private var showingMenu = false
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                NavigationView {
                    ZStack {
//                        if showingMenu {
//                            SideMenuView(isShowing: $showingMenu)
//                                .padding(.top, 44)
//                                .ignoresSafeArea()
//                        }
                        MainTabView(selectedIndex: $selectedIndex)
                            .ignoresSafeArea()
                            .navigationTitle(viewModel.tabTitle(forIndex: selectedIndex))
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarItems(leading: Button(action: {
                                viewModel.signOut()
                            }, label: {
                                if let user = viewModel.user {
                                    KFImage(URL(string: user.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 32, height: 32)
                                        .cornerRadius(16)
                                }
                            }))
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
