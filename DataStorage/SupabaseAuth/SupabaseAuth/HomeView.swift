//
//  HomeView.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 27.08.2023.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        if let appUser = appUser {
            VStack {
                Text(appUser.uid)
                Text(appUser.email ?? "No Email")
                
                Button {
                    Task {
                        do {
                            try await AuthManager.shared.signOut()
                            self.appUser = nil
                        } catch {
                            print("unable to sign out")
                        }
                    }
                } label: {
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(appUser: .constant(.init(uid: "123", email: "example@gmail.com")))
    }
}
