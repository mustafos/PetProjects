import Foundation
import Alamofire

class NetworkServiceWithAlamofire {
    static let shared =  NetworkServiceWithAlamofire(); private init() {}
    
    private func createURL() -> String {
        let tunnel = "https://"
        let server = "randomuser.me"
        let endpoint = "/api"
        let getParams = ""
        let url = tunnel + server + endpoint + getParams
        return url
    }
    
    func fetchData(completion: @escaping (Result<UserResults, Error>) -> ()) {
        AF.request(createURL())
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userResults = try? decoder.decode(UserResults.self, from: data) else {
                    completion(.failure(NetworkingError.invalidData))
                    return
                }
                completion(.success(userResults))
            }
    }
}
