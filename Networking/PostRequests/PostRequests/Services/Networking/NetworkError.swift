import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case badResponse
    case invalidDecoding
}
