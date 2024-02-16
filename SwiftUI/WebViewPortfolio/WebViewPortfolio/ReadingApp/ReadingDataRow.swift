//
//  ReadingDataRow.swift
//  WebViewPortfolio
//
//  Created by Mustafa Bekirov on 08.02.2024.
//

import SwiftUI

struct ReadingDataRow: View {
    let readingData: ReadingData
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: readingData.hasFinishedReading ? "book.fill" : "book")
                .foregroundColor(.green)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(readingData.title)
                    .bold()
                Text(readingData.creationDate,
                     format: .dateTime.day().month().year())
            }
            Spacer()
           
        }
    }
}

#Preview {
    ReadingDataRow(readingData: ReadingData.example())
}
