import SwiftUI
import Firebase

class ChatViewModel: ObservableObject {
    let user: User
    @Published var message = [Message]()
    
    init(user: User) {
        self.user = user
        fetchMessages()
    }
    
    func fetchMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection(user.id)
        query.order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            
            changes.forEach { change in
                let messageDate = change.document.data()
                guard let fromId = messageDate["fromId"] as? String else { return }
                
                COLLECTION_USERS.document(fromId).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.message.append(Message(user: user, dictionary: messageDate))
                }
            }
        }
    }
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(user.id).document()
        let receivingUserRef = COLLECTION_MESSAGES.document(user.id).collection(currentUid)
        let receivingRecentRef = COLLECTION_MESSAGES.document(user.id).collection("recent-messages")
        let currentRecentRef = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages")
        
        let messageID = currentUserRef.documentID
        let data: [String: Any] = ["text": messageText, "id": messageID,
                                   "fromId": currentUid, "toId": user.id,
                                   "timestamp": Timestamp(date: Date())]
        
        currentUserRef.setData(data)
        receivingUserRef.document(messageID).setData(data)
        receivingRecentRef.document(currentUid).setData(data)
        currentRecentRef.document(user.id).setData(data)
    }
}
