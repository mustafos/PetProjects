//
//  HexagonView.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 03.04.2023.
//

import SwiftUI

struct HexagonView: View {
    var body: some View {
        Canvas { context, size in
            let image = context.resolve(Image(systemName: "hexagon.fill"))
            let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context.draw(image, in: frame)
        }
        .frame(width: 200, height: 220)
        .foregroundStyle(.linearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct HexagonView_Previews: PreviewProvider {
    static var previews: some View {
        HexagonView()
    }
}

