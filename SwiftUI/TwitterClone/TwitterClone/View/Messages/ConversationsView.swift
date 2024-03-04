import SwiftUI

struct ConversationsView: View {
    
    @State var isShowingNewMessageView = false
    @State var showChat = true
    @State var user: User?
    @ObservedObject var viewModel = ConversationsViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if let user = user {
                NavigationLink(destination: LazyView(ChatView(user: user)),
                               isActive: $showChat,
                               label: {})
            }
            ScrollView {
                VStack {
                    ForEach(viewModel.recentMessages) { message in
                        NavigationLink {
                            LazyView(ChatView(user: message.user))
                        } label: {
                            ConversationCell(message: message)
                        }
                    }
                }
                .padding()
            }
            
            Button {
                self.isShowingNewMessageView.toggle()
            } label: {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $isShowingNewMessageView) {
                NewMessageView(show: $isShowingNewMessageView, startChat: $showChat, user: $user)
            }
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
