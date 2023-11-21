//
//  AppStorageUserDefault.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 08.11.2023.
//

import SwiftUI

struct AppStorageUserDefault: View {
    @AppStorage("name") var currentUserName: String?
    var body: some View {
        VStack(spacing: 20) {
            Text(currentUserName ?? "Add Name Here")
            if let name = currentUserName {
                Text(name)
            }
            Button("SAVE") {
                let name: String = "Alexa"
                currentUserName = name
            }
        }
    }
}

#Preview {
    AppStorageUserDefault()
}
