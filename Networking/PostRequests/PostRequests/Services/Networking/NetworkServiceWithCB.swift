import Foundation

class NetworkServiceWithCB {
    static let shared = NetworkServiceWithCB(); private init() {}
    
    func createToDo(_ dto: ToDo.TodoDTO, completion: @escaping (Result<ToDo, Error>) -> ()) {
        guard let url = URLManager.shared.createURL(endPoint: .todos, id: nil) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        /*Create request*/
        var req = URLRequest(url: url)
        
        /*Settings request*/
        req.httpMethod = "POST"
        req.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        let encoder = JSONEncoder()
        guard let body = try? encoder.encode(dto) else {
            completion(.failure(NetworkError.invalidEncoding))
            return
        }
        req.httpBody = body
        
        /*Send request | Get response*/
        let task = URLSession.shared.dataTask(with: req) { data, response, error in
            guard let data else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            
            /*Decoding the received data into a Swift-model*/
            let decoder = JSONDecoder()
            guard let todo = try? decoder.decode(ToDo.self, from: data) else {
                completion(.failure(NetworkError.invalidDecoding))
                return
            }
            completion(.success(todo))
        }
        task.resume()
    }
}
