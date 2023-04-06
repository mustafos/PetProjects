//
//  CertificateViewModel.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 05.04.2023.
//

import Foundation
import Firebase

final class CertificateViewModel: ObservableObject {
    @Published var certificates: [Certificate] = []
    
    init() {
        fetchCertificates()
    }

    func fetchCertificates() {
        let db = Firestore.firestore()

        db.collection("certificates").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        let data = document.data()
//                        print("Certificate \(document.documentID): \(data)")

                        let id = data["id"] as? String ?? ""
                        let course = data["course"] as? String ?? ""
                        let dateValue = (data["date"] as AnyObject).dateValue().formatDate()
//                        let date = dateValue.formatDate()
                        let logo = data["logo"] as? String ?? ""
                        let instructor = data["instructor"] as? String ?? ""

                        let certificate = Certificate(id: id, course: course, date: dateValue, logo: logo, instructor: instructor)
                        
                        self.certificates.append(certificate)
                    }
                }
            }
        }
    }
}
