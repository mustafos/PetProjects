//
//  TipView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 23.03.2024.
//

import SwiftUI
import TipKit

struct TipView: View {
    
    private let favTip = FavoriteTip()
    
    var body: some View {
        ZStack {
            Color.red
            VStack {
                Image("1")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "heart")
                            .font(.system(size: 24))
                            .foregroundStyle(.yellow)
                            .padding()
                            .popoverTip(favTip, arrowEdge: .bottom)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 60)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TipView()
}

struct FavoriteTip: Tip {
    var title: Text {
        Text("Save the photo as favorite")
    }
    
    var message: Text? {
        Text("Your favorite photos will appear in the favorite folder")
    }
    
    var image: Image? {
        Image(systemName: "heart")
    }
}
