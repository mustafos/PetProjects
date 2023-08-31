//
//  DatabaseManager.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 30.08.2023.
//

import Foundation
import Supabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    let client = SupabaseClient(
        supabaseURL: URL(string: "https://ypcrzbibwjnnvedmywfm.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwY3J6Ymlid2pubnZlZG15d2ZtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTMxMzgzNjEsImV4cCI6MjAwODcxNDM2MX0.waHwBq9ian-TBmM0HbQz25_TB6NUOCwyHwV_nw90Khg")
    
    func createToDoItem(item: ToDoPlayLoad) async throws {
        let response = try await client.database.from("todos").insert(values: item).execute()
        print(response)
    }
    
    func fetchToDoItem(for uid: String) async throws -> [ToDo] {
        let response = try await client.database.from("todos").select().equals(column: "user-uid", value: uid).order(column: "created_at", ascending: true).execute()
        let data = response.underlyingResponse.data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let todos = try decoder.decode([ToDo].self, from: data)
        return todos
    }
}
