//
//  ToDoViewModel.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 31.08.2023.
//

import Foundation

class ToDoViewModel: ObservableObject {
    
    @Published var todos = [ToDo]()
    
    var mockData = [
        ToDoPlayLoad(text: "Homework", userUid: ""),
        ToDoPlayLoad(text: "Code", userUid: ""),
        ToDoPlayLoad(text: "Gym", userUid: ""),
        ToDoPlayLoad(text: "Sleep", userUid: "")
    ]
    
    // MARK: Create
    func createItems(text: String, uid: String) async throws {
        guard !todos.contains(where: { $0.text.lowercased() == text.lowercased() }) else {
            print("Already in todo list")
            throw NSError()
        }
        let toDo = ToDoPlayLoad(text: text, userUid: uid)
        try await DatabaseManager.shared.createToDoItem(item: toDo)
    }
    
    // MARK: Read
    @MainActor
    func fetchItems(for uid: String) async throws {
        todos = try await DatabaseManager.shared.fetchToDoItem(for: uid)
    }
    
    // MARK: Delete
    @MainActor
    func deleteItems(todo: ToDo) async throws {
        try await DatabaseManager.shared.deleteToDoItem(id: todo.id)
        todos.removeAll(where: { $0.id == todo.id })
    }
}
