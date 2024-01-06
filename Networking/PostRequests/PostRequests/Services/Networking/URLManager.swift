import Foundation

class URLManager {
    static let shared = URLManager(); private init() {}
    
    private let tunnel = "https://"
    private let server = "jsonplaceholder.typicode.com"
    
    func createURL(endPoint: EndPoint, id: Int?) -> URL? {
        var str = tunnel + server + endPoint.rawValue
        if let id {
            str += "/\(id)"
        }
        let url = URL(string: str)
        return url
    }
}

enum EndPoint: String {
    case todos = "/todos"
    case users = "/users"
}
