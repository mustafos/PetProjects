import SwiftUI
import Firebase

class UploadTweetViewModel: ObservableObject {
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    func uploadTweet(caption: String) {
        guard let user = AuthViewModel.shared.user else { return }
        let docRef = COLLECTION_TWEETS.document()
        let data: [String: Any] = ["uid": user.id,
                                   "caption": caption,
                                   "fullname": user.fullname,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImageUrl,
                                   "likes": 0,
                                   "id": docRef.documentID]
        
        docRef.setData(data) { _ in
            print("DEBUG: Seccessfully uploaded tweet..")
            self.isPresented = false
        }
    }
    
/// User completion handler to dismiss view

//    func uploadTweet(caption: String, completion: @escaping ((Error? -> Void))) {
//        guard let user = AuthViewModel.shared.user else { return }
//        let docRef = COLLECTION_TWEETS.document()
//        let data: [String: Any] = ["uid": user.id,
//                                   "caption": caption,
//                                   "fullname": user.fullname,
//                                   "timestamp": Timestamp(date: Date()),
//                                   "username": user.username,
//                                   "profileImageUrl": user.profileImageUrl,
//                                   "likes": 0,
//                                   "id": docRef.documentID]
//
//        docRef.setData(data, completion: completion)
//    }
}
