//
//  TextEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 17.05.2023.
//

import SwiftUI

struct TextEx: View {
    var body: some View {
            Text("Beauty and window are seldom found together".uppercased())
                .font(.title)
                .kerning(1)
                .italic()
                .bold()
                .underline(true, color: .yellow)
                .strikethrough(true, color: .red)
                .padding()
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .background(.red)
                .foregroundColor(.white)
                .lineSpacing(10)
                .font(.system(size: 24, weight: .bold, design: .serif))
                .frame(width: 200, height: 100, alignment: .leading)
                .minimumScaleFactor(0.5)
                Text("Hello")
                    .baselineOffset(-10)
                    .border(Color.red)
                Text("Hello")
                    .border(Color.green)
                Text("Hello")
                    .baselineOffset(10)
                    .border(Color.blue)
            }
//            .background(Color)
    }

struct TextEx_Previews: PreviewProvider {
    static var previews: some View {
        TextEx()
    }
}
