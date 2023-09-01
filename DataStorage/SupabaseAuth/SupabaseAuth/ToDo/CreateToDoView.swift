//
//  CreateToDoView.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 31.08.2023.
//

import SwiftUI

struct CreateToDoView: View {
    
    @EnvironmentObject var viewModel: ToDoViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var appUser: AppUser
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Create a ToDo")
                .font(.largeTitle)

            AppTextField(placeholder: "Please enter your task", text: $text)
            
            Button {
                if text.count > 2 {
                    Task {
                        do {
                            try await viewModel.createItems(text: text, uid: appUser.uid)
                            dismiss()
                        } catch {
                            print("error")
                        }
                    }
                }
            } label: {
                Text("Create")
                    .padding()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(uiColor: .label))
                    }
            }
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.all)
    }
}

struct CreateToDoView_Previews: PreviewProvider {
    static var previews: some View {
        CreateToDoView(appUser: .init(uid: "", email: ""))
            .environmentObject(ToDoViewModel())
    }
}
