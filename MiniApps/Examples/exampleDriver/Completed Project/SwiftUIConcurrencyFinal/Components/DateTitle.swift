//
//  DateTitle.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-15.
//

import SwiftUI

struct DateTitle: View {
    var title: AttributedString
    @State private var date: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(date.uppercased())
                .font(.footnote)
                .fontWeight(.medium)
                .opacity(0.7)
            
            Text(title)
                .font(.largeTitle).bold()
                .accessibilityAddTraits([.isHeader])
        }
        .onAppear {
            date = Date.now.formatted(.dateTime.weekday(.wide).day().month())
        }
    }
}

struct DateTitle_Previews: PreviewProvider {
    static var attributedString: AttributedString {
        var subject = AttributedString("SwiftUI")
        
        var container = AttributeContainer()
        container.foregroundColor = .purple
        subject.mergeAttributes(container)
        
        return "Learn " + subject
    }
    
    static var previews: some View {
        DateTitle(title: attributedString)
    }
}
