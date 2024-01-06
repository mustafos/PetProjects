import Foundation

enum MainViewModel: Int, CaseIterable {
    case array1
    case set2
    case dictionary3
    
    var description: String {
        switch self {
            case .array1: return "Array"
            case .set2: return "Set"
            case .dictionary3: return "Dictionary"
        }
    }
}
