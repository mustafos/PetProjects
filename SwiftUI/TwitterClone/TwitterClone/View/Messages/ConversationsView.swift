import SwiftUI

struct ConversationsView: View {
    
    @State private var isShowingNewMessageView = false
    @State private var showChat = true
    @State private var inSearchMode = false
    @ObservedObject var viewModel = ConversationsViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            //            NavigationLink(destination: ChatView(),
            //                           isActive: $showChat,
            //                           label: {} )
            
            ScrollView {
                VStack {
                    ForEach(viewModel.recentMessages) { message in
                        NavigationLink {
                            ChatView(user: message.user)
                        } label: {
                            ConversationCell()
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
                NewMessageView(show: $isShowingNewMessageView, startChat: $showChat)
            }
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
