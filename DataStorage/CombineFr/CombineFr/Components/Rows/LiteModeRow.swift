//
//  LiteModeRow.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 07.04.2023.
//

import SwiftUI

struct LiteModeRow: View {
    @AppStorage("isLiteMode") var isLiteMode: Bool = false
    
    var body: some View {
        Toggle(isOn: $isLiteMode, label: {
            HStack(spacing: 12) {
                GradientIcon(icon: "speedometer")
                
                VStack(alignment: .leading) {
                    Text("Lite Mode")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Better performance. Recommended for iPhone X and older.")
                        .font(.caption2)
                        .opacity(0.7)
                }
            }
        })
        .toggleStyle(SwitchToggleStyle(tint: Color(#colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1))))
    }
}

struct LitModeRow_Previews: PreviewProvider {
    static var previews: some View {
        LiteModeRow()
    }
}
