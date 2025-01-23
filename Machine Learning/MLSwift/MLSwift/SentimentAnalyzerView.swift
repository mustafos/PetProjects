//
//  SentimentAnalyzerView.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 12.01.2025.
//

import SwiftUI
import NaturalLanguage

struct SentimentAnalyzerView: View {
    @State private var inputText: String = ""
    
    private var score: String {
        return analyzeSentiment(for: inputText)
    }
    
    private let tagger = NLTagger(tagSchemes: [.sentimentScore])
    
    private func analyzeSentiment(for stringToAnalyze: String) -> String {
        tagger.string = stringToAnalyze
        let (sentimentScore, _) = tagger.tag(at: stringToAnalyze.startIndex,
                                            unit: .paragraph,
                                            scheme: .sentimentScore
        )
        return sentimentScore?.rawValue ?? ""
    }
    
    var body: some View {
        VStack {
            Text("Sentiment Analyzer")
            
            TextField("Enter text here", text: $inputText)
            
            Text(score)
        }
        .font(.system(size: 40))
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    SentimentAnalyzerView()
}
