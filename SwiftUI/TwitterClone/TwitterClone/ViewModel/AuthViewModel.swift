import SwiftUI
import Firebase
import FirebaseStorage

class AuthViewModel: ObservableObject {
    
    func login() {
        
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Succesfully uploaded user photo..")
            
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    guard let user = result?.user else { return }
                    let data = ["email": email, "username": username, "fullname": fullname, "profileImageUrl": profileImageUrl, "uid": user.uid]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        print("DEBUG: Succesfully uploaded user data..")
                    }
                }
            }
        }
    }
}
