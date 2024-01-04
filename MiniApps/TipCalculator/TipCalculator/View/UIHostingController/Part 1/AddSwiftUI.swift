//
//  AddSwiftUI.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 03.01.2024.
//

import SwiftUI

struct AddSwiftUI: View {
    @State private var isOn = false
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscribre")
                    })
                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscribre")
                    })
                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscribre")
                    })
                }
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    AddSwiftUI()
}
