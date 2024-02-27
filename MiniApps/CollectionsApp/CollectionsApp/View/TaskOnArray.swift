import Foundation

protocol Operation {
    var description: String { get }
}

enum TaskOnArray: Operation, CaseIterable {
    case throusndElementsAtBeginingByOne
    case throusndElementsAtBegining
    case throusndElementsAtMiddleByOne
    case throusndElementsAtMiddle
    case throusndElementsAtEndByOne
    case throusndElementsAtEnd
    case throusndElementsAtEndByAll
    case throusndElementsRemoveAtEndAll
    case throusndElementsRemoveAtBeginingByOne
    case throusndElementsRemoveAtBegining
    case throusndElementsRemoveAtMiddleByOne
    case throusndElementsRemoveAtMiddle
    case throusndElementsRemoveAtEndByOne
    case throusndElementsRemoveAtEnd
    
    var description: String {
        switch self {
            case .throusndElementsAtBeginingByOne:
                return "Insert 1000 elements at the beginning of the array one-by-one"
            case .throusndElementsAtBegining:
                return "Insert 1000 elements at the beginning of the array."
            case .throusndElementsAtMiddleByOne:
                return "Insert 1000 elements in the middle of the array one-by-one"
            case .throusndElementsAtMiddle:
                return "Insert 1000 elements in the middle of the array."
            case .throusndElementsAtEndByOne:
                return "Insert 1000 elements at the end of the array one-by-one"
            case .throusndElementsAtEnd:
                return "Insert 1000 elements at the end of the array."
            case .throusndElementsAtEndByAll:
                return "Insert 1000 elements at the end of the array for all"
            case .throusndElementsRemoveAtEndAll:
                return "Insert 1000 elements at the end of the array all at once"
            case .throusndElementsRemoveAtBeginingByOne:
                return "Remove 1000 elements at the beginning of the array one-by-one"
            case .throusndElementsRemoveAtBegining:
                return "Remove 1000 elements at the beginning of the array."
            case .throusndElementsRemoveAtMiddleByOne:
                return "Remove 1000 elements in the middle of the array one-by-one"
            case .throusndElementsRemoveAtMiddle:
                return "Remove 1000 elements in the middle of the array."
            case .throusndElementsRemoveAtEndByOne:
                return "Remove 1000 elements at the end of the array one-by-one"
            case .throusndElementsRemoveAtEnd:
                return "Remove 1000 elements at the end of the array."
        }
    }
}
