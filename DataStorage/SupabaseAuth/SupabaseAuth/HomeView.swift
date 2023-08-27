//
//  HomeView.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 27.08.2023.
//

import SwiftUI

struct HomeView: View {
    
    @State var appUser: AppUser
    
    var body: some View {
        VStack {
            Text(appUser.uid)
            Text(appUser.email ?? "No Email Address")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(appUser: .init(uid: "123", email: "example@example.com"))
    }
}
