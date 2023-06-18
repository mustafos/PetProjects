import Foundation
import Supabase

class QuizManager: ObservableObject {
    
    @Published var questions = [Question]()
    
//    @Published var questions = [
//        Question(title: "When was the iPhone first released?", answer: "A", options: ["A", "B", "C", "D"]),
//        Question(title: "iPhone first released?", answer: "A", options: ["A", "B", "C"]),
//        Question(title: "When was the iPhone?", answer: "A", options: ["A", "B", "C"]),
//        Question(title: "the iPhone first released?", answer: "A", options: ["A", "B"])
//    ]
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://jcvpfuzxclsxrwhwxzbv.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpjdnBmdXp4Y2xzeHJ3aHd4emJ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODcxMTI4NzMsImV4cCI6MjAwMjY4ODg3M30.YLDeHlPpkQtDbrpJnwZ23rip1foPNbPO7au1J71jHG4")
    
    init() {
        Task {
            do {
                let response = try await client.database.from("quiz").select().execute()
                let data = response.underlyingResponse.data
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let questions = try decoder.decode([Question].self, from: data)
                await MainActor.run {
                    self.questions = questions
                }
            } catch {
                print("error fetching questions")
            }
        }
    }
    
    func canSubmitQuiz() -> Bool {
        return questions.filter({ $0.selection == nil }).isEmpty
    }
    
    func qradeQuiz() -> String {
        var correct: CGFloat = 0
        for question in questions {
            if question.answer == question.selection {
                correct += 1
            }
        }
        return "\((correct/CGFloat(questions.count)) * 100) %"
    }
}
