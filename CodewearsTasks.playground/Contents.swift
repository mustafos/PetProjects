import Foundation

func boolToWord(_ bool: Bool) -> String {
    bool ? "Yes" : "No"
}

func reverse(_ str: String) -> String {
    var reversedWord = String(str.reversed())
    return reversedWord
}

func descendingOrder(of number: Int) -> Int {
    var numStr = String(number)
    var sortedStr = numStr.sorted(by: >)
    for _ in sortedStr {
        String(sortedStr)
    }
    let result = String(sortedStr)
    let final = Int(result)
    return final!
}

//func toLeetSpeak(_ s : String) -> String {
    let alphabet = [
        "A" : "@",
        "B" : "8",
        "C" : "(",
        "D" : "D",
        "E" : "3",
        "F" : "F",
        "G" : "6",
        "H" : "#",
        "I" : "!",
        "J" : "J",
        "K" : "K",
        "L" : "1",
        "M" : "M",
        "N" : "N",
        "O" : "0",
        "P" : "P",
        "Q" : "Q",
        "R" : "R",
        "S" : "$",
        "T" : "7",
        "U" : "U",
        "V" : "V",
        "W": "W",
        "X" : "X",
        "Y" : "Y",
        "Z" : "2"
    ]
    
let aString = String("LEET")
for _ in alphabet {
    aString. == alphabet.keys
}

