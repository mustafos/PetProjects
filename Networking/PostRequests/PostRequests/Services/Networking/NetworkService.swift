import Foundation

class NetworkService {
    static let shared = NetworkService(); private init() {}
    
    func getAllTodos() async throws -> [ToDo] {
        guard let url = URLManager.shared.createURL(endPoint: .todos, id: nil) else {
            throw NetworkError.badURL
        }
        do {
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            let jsonDecoder = JSONDecoder()
            let todos = try jsonDecoder.decode([ToDo].self, from: data)
            return todos
        } catch { throw error }
    }
    
    func createToDo(_ dto: ToDo.TodoDTO) async throws -> ToDo {
        guard let url = URLManager.shared.createURL(endPoint: .todos, id: nil) else {
            throw NetworkError.badURL
        }
        /*Create request*/
        var req = URLRequest(url: url)
        
        /*Settings request*/
        req.httpMethod = "POST"
        req.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        let encoder = JSONEncoder()
        let body = try encoder.encode(dto)
        req.httpBody = body
        
        /*Send request | Get response*/
        let response = try await URLSession.shared.data(for: req)
        /*Extracting data from a response*/
        let data = response.0
        
        /*Decoding the received data into a Swift-model*/
        let decoder = JSONDecoder()
        let todo = try decoder.decode(ToDo.self, from: data)
        return todo
    }
}
