import SwiftUI

struct ConversationsView: View {
    
    @State private var isShowingNewMessageView = false
    @State private var showChat = true
    @State private var inSearchMode = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
//            NavigationLink(destination: ChatView(),
//                           isActive: $showChat,
//                           label: {} )
            ScrollView {
                VStack {
                    ForEach(0..<9) { _ in
                        ConversationCell()
//                        NavigationLink {
//                            ChatView()
//                        } label: {
//                            ConversationCell()
//                        }
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
