//
//  ToggleEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 02.05.2023.
//

import SwiftUI

struct ToggleEx: View {
    
    @State var isOnToggle = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack{
                        Text("Wallet")
                        Text("Profile")
                        Spacer().frame(width: 100, height: 10)
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 10).fill(Color.yellow).offset(x: isOnToggle ? 200 : 0)
                Text("Something in screen").offset(x: isOnToggle ? 100 : 0)
            }
            Toggle(isOn: $isOnToggle) {
                Text("View settings")
            }.padding()
        }.animation(.spring(response: 0.8, dampingFraction: 0.2, blendDuration: 0.3))
    }
}

struct ToggleEx_Previews: PreviewProvider {
    static var previews: some View {
        ToggleEx()
    }
}
