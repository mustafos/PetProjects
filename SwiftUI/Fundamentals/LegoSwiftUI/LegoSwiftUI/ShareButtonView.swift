//
//  ShareButtonView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 02.04.2024.
//

import SwiftUI

struct ShareButtonView: View {
    var body: some View {
        VStack {
            ShareLink(item: URL(string: "https://www.youtube.com/channel/UC6_OqZ5y84n7YnvxOIzJ9-w")!) {
                Text("Share this YouTube channel")
                Image(systemName: "play.rectangle.fill")
                    .foregroundStyle(.red)
            }
        }
        .padding()
    }
}

#Preview {
    ShareButtonView()
}
