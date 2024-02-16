import Foundation
import Alamofire

class NetworkServiceWithAlamofire {
    static let shared = NetworkServiceWithAlamofire(); private init() {}
    
    func createToDo(_ dto: ToDo.TodoDTO, completion: @escaping (Result<ToDo, Error>) -> ()) {
        guard let url = URLManager.shared.createURL(endPoint: .todos, id: nil) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        let header = HTTPHeader(name: "Content-type", value: "application/json; charset=UTF-8")
        
        AF.request(url, method: .post,
                   parameters: dto, encoder: .json,
                   headers: [header]).validate().response { response in
            guard let data = response.data else {
                if let error = response.error {
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
    }
}
