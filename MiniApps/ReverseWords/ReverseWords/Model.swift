import Foundation

class ReverseWordsModel {
    
    func reverseWords(in inputString: String) -> String {
        let words = inputString.components(separatedBy: .whitespaces)
        let reversedWords = words.map { String($0.reversed()) }
        return reversedWords.joined(separator: " ")
    }
    
    func reverseExceptAlphabeticSymbols(in inputString: String) -> String {
        let words = inputString.components(separatedBy: .whitespaces)
        let reversedWords = words.map { reverseWordExceptAlphabeticSymbols($0) }
        return reversedWords.joined(separator: " ")
    }
    
    func reverseIgnoredUserDefined(in inputString: String, ignoredChars: String) -> String {
        let words = inputString.components(separatedBy: .whitespaces)
        let reversedWords = words.map { reverseWordIgnoringUserDefinedCharacters($0, ignoredChars: ignoredChars) }
        return reversedWords.joined(separator: " ")
    }
    
    private func reverseWordExceptAlphabeticSymbols(_ word: String) -> String {
        let letters = word.filter(\.isLetter)
        var reversedLetters = String(letters.reversed())
        var result = ""
        for c in word {
            if c.isLetter {
                result.append(reversedLetters.removeFirst())
            } else {
                result.append(c)
            }
        }
        return result
    }
    
    private func reverseWordIgnoringUserDefinedCharacters(_ word: String, ignoredChars: String) -> String {
        var chars = Array(word)
        var i = 0, j = chars.count - 1
        while i < j {
            if ignoredChars.contains(chars[i]) {
                i += 1
                continue
            }
            if ignoredChars.contains(chars[j]) {
                j -= 1
                continue
            }
            chars.swapAt(i, j)
            i += 1
            j -= 1
        }
        return String(chars)
    }
}
