//
//  StorageManager.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 01.09.2023.
//

import Foundation
import SupabaseStorage

class StorageManager {
    
    static let shared = StorageManager()
    
    private let apikey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwY3J6Ymlid2pubnZlZG15d2ZtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTMxMzgzNjEsImV4cCI6MjAwODcxNDM2MX0.waHwBq9ian-TBmM0HbQz25_TB6NUOCwyHwV_nw90Khg"
    
    private let secret = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwY3J6Ymlid2pubnZlZG15d2ZtIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5MzEzODM2MSwiZXhwIjoyMDA4NzE0MzYxfQ.UhVNX205aEDfDZPw1cRi4usTfB7vJ2HHhrOzWK-z7oM"
    
    lazy var storage = SupabaseStorageClient(url: "https://ypcrzbibwjnnvedmywfm.supabase.co/storage/v1", headers: ["Authorization" : "Bearer \(secret)", "apikey" : apikey])
    
    func uploadProfilePhoto(for user: AppUser, photoData: Data) async throws {
        let file = File(name: "profile_photo", data: photoData, fileName: "profile_photo.jpg", contentType: "jpg")
        
        do {
            try await storage.from(id: "images").list(path: "\(user.uid)")
            let result = try await storage.from(id: "images").upload(path: "\(user.uid)/profile_photo.jpg", file: file, fileOptions: FileOptions(cacheControl: "2400"))
            print(result)
        } catch {
            let result = try await storage.from(id: "images").upload(path: "\(user.uid)/profile_photo.jpg", file: file, fileOptions: FileOptions(cacheControl: "2400"))
            print(result)
        }
    }
    
    func fetchProfilePhoto(for user: AppUser) async throws -> Data {
        return try await storage.from(id: "images").download(path: "\(user.uid)/profile_photo.jpg")
    }
}
