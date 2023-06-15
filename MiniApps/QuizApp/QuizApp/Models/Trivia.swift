import Foundation

struct Trivia: Decodable {
    var results: [Result]
    
    struct Result: Decodable, Identifiable {
        var id: UUID {
            UUID()
        }
        var category: String
        var type: String
        var difficulty: String
        var question: String
        var correctAnswer: String
        var incorrectAnswers: [String]
        
        var formattedQuestion: AttributedString {
            // Replace `AttributedString` with the correct type or library you're using
            do {
                return try AttributedString(markdown: question)
            } catch {
                print("Error setting formattedQuestion: \(error)")
                return AttributedString("") // Return a default value in case of an error
            }
        }
        
        var answers: [Answer] {
            // Replace `AttributedString` with the correct type or library you're using
            do {
                let correct = [Answer(text: try AttributedString(markdown: correctAnswer), isCorrect: true)]
                let incorrect = try incorrectAnswers.map { answer in
                    Answer(text: try AttributedString(markdown: answer), isCorrect: false)
                }
                let allAnswers = correct + incorrect
                return allAnswers.shuffled()
            } catch {
                print("Error setting answers: \(error)")
                return [] // Return an empty array in case of an error
            }
        }
    }
}
