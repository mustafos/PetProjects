//
//  QuizManager.swift
//  QuizAll
//
//  Created by Mustafa Bekirov on 02.09.2023.
//

import Foundation
import Supabase

class QuizManager: ObservableObject {
    
    @Published var questions = [Question]()
    @Published var quizResult = QuizResult(correct: 0, total: 0, grade: "100%")
    
//    @Published var mockQuestions = [
//        Question(title: "When was the iPhone firs released?", answer: "A", options: ["A", "B", "C", "D"]),
//        Question(title: "Do you eat or drink soup?", answer: "A", options: ["A", "B", "C", "D"]),
//        Question(title: "What is the best gift you have ever received?", answer: "A", options: ["A", "B", "C", "D"]),
//        Question(title: "What's your favorite family recipe?", answer: "A", options: ["A", "B", "C", "D"]),
//        Question(title: "What is your favorite animal?", answer: "A", options: ["A", "B", "C", "D"])
//    ]
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://jabltlxjhxwbdwoovtmb.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImphYmx0bHhqaHh3YmR3b292dG1iIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTM2NDM5NzcsImV4cCI6MjAwOTIxOTk3N30.hK051_J7r83cA6jAdgFDzZiTdiFfth0EZIB8RRZGuc8")
    
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
                print("error")
            }
        }
    }
    
    func canSubmitQuiz() -> Bool {
        return questions.filter({ $0.selection == nil }).isEmpty
    }
    
    func gradeQuiz() {
        var correct: CGFloat = 0
        for question in questions {
            if question.answer == question.selection {
                correct += 1
            }
        }
        self.quizResult = QuizResult(correct: Int(correct), total: questions.count, grade: "\((correct/CGFloat(questions.count)) * 100)%")
    }
    
    func resetQuiz() {
        self.questions = questions.map({Question(id: $0.id, createdAt: $0.createdAt, title: $0.title, answer: $0.answer, options: $0.options, selection: nil)})
    }
}

struct QuizResult {
    let correct: Int
    let total: Int
    let grade: String
}
