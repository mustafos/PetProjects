//
//  MarkdownTextView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 01.04.2024.
//

import SwiftUI

struct MarkdownTextView: View {
    
    let markdownText: String =
"""
**Bold**
*Italic*
~~Strikethrough~~
1. Ordered list
```
Code -> let text: String
```
[Link](www.google.com)
"""

    var body: some View {
        VStack {
            Text(.init(markdownText))
                .font(.system(size: 35))
                
        }
        .padding()
    }
}

#Preview {
    MarkdownTextView()
}
