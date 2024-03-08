import SwiftUI
import Firebase

enum SearchViewModelConfiguration {
    case search
    case newMessage
}

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    private let config: SearchViewModelConfiguration
    
    init(config: SearchViewModelConfiguration) {
        self.config = config
        fetchUsers(forConfig: config)
    }
    
    func fetchUsers(forConfig config: SearchViewModelConfiguration) {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let users = documents.map({ User(dictionary: $0.data()) })
            
            switch config {
                case .newMessage:
                    self.users = users.filter({ !$0.isCurrentUser })
                case .search:
                    self.users = users
            }
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercaseQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercaseQuery) ||
            $0.username.contains(lowercaseQuery) })
    }
}
