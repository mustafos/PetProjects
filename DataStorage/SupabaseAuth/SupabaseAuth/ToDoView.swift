//
//  ToDoView.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 30.08.2023.
//

import SwiftUI

struct ToDoView: View {
    
    @StateObject var viewModel = ToDoViewModel()
    @State var appUser: AppUser
    
    var body: some View {
        NavigationStack {
            ZStack {
                LazyVStack {
                    ForEach(viewModel.todos, id: \.text) { todo in
                        Text(todo.text)
                    }
                }
            }
            .navigationTitle("ToDo")
            .toolbar {
                NavigationLink {
                    CreateToDoView(appUser: appUser)
                        .environmentObject(viewModel)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding(.all, 2)
                        .foregroundColor(.green)
                }
            }
            .onAppear {
                Task {
                    do {
                        try await viewModel.fetchItems(for: appUser.uid)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView(appUser: .init(uid: "", email: ""))
    }
}
