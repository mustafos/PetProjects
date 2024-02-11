import Foundation

struct ToDo: Identifiable, Codable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
    
    var dto: TodoDTO {
        let dto = TodoDTO(userId: userId, title: title, completed: completed)
        return dto
    }
    
    struct TodoDTO: Encodable {
        let userId: Int
        let title: String
        let completed: Bool
    }
}
