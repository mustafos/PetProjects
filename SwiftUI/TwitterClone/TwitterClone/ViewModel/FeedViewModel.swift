//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Mustafa Bekirov on 07.09.2023.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        COLLECTION_TWEETS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.tweets = documents.map({ Tweet(dictionary: $0.data()) })
            print("DEBUG: Tweets \(self.tweets)")
        }
    }
}
