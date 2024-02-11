import Foundation

enum TaskOnDictionary: Operation, CaseIterable {
    case findTheFirstContactInArray
    case findTheFirstContactInDictionary
    case findTheLastContactInArray
    case findTheLastContactInDictionary
    case searchForNonExistArray
    case searchForNonExistDictionary
    
    var description: String {
        switch self {
            case .findTheFirstContactInArray:
                return "Find the first contact"
            case .findTheFirstContactInDictionary:
                return "Find the first contact"
            case .findTheLastContactInArray:
                return "Find the last contact"
            case .findTheLastContactInDictionary:
                return "Find the last contact"
            case .searchForNonExistArray:
                return "Search for a non-existing element"
            case .searchForNonExistDictionary:
                return "Search for a non-existing element"
        }
    }
}
