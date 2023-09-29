//
//  SectionViewModel.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-18.
//

import Foundation
import Apollo

class SectionViewModel: ObservableObject {
    @Published public var sections: [SectionsDataCollection.SectionModel] = []
    @Published public private(set) var filteredSections: [SectionsDataCollection.SectionModel] = []

    private func querySections() async throws -> GraphQLResult<SectionQuery.Data>? {
        return await withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: SectionQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    continuation.resume(returning: graphQLResult)
                case .failure(let error):
                    if let error = error as? Never {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func fetch() async {
        do {
            let result = try await querySections() // Fetching the sections with Apollo
            if let result = result {
                if let sectionCollection = result.data?.sectionCollection { // Unwrapping the optional result we get from Apollo
                    
                    // Processing the data into the model, and assigning it to the sections variable
                    sections = process(data: sectionCollection)
                }
            }
        } catch {
            print("error", error)
        }
    }
    
    private func process(data: SectionQuery.Data.SectionCollection) -> [SectionsDataCollection.SectionModel] {
        let content = SectionsDataCollection.init(data)
        
        return content.sections
    }
    
    func randomizeSections() async {
        sections.shuffle()
    }
    
    func orderSectionsByPinned() {
        sections.sort { $0.isPinned && !$1.isPinned }
    }
    
    func filterSections(for text: String) {
        filteredSections = [] // Resetting the filteredSections array
        let searchText = text.lowercased() // Making the search text lowercased
        
        sections.forEach { section in // For each section in the sections array
            let searchContent = section.title // Take its title
            if searchContent.lowercased().range(of: searchText, options: .regularExpression) != nil { // Check if search content mathces the searchText
                
                // If there's a match, append the section to the filteredSections array
                filteredSections.append(section)
            }
        }
    }
}
