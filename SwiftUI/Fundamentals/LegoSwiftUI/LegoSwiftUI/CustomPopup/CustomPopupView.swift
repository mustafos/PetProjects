//
//  CustomPopupView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 13.10.2024.
//

import SwiftUI

struct CustomPopupView: View {
    @State private var showPasswordPrompt = false
    @State private var showErrorAlert = false
    @State private var showSuccessAlert = false
    @State private var showConfirmationDialog = false
    @State private var showInfoAlert = false
    @State private var showWarningAlert = false
    @State private var showCustomInputDialog = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color("BackgroundTop"), Color("BackgroundBottom")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                
                    VStack(spacing: 30) {
                        // Header Image
                        Image("header_image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .clipped()
                            .padding(.top, 20)

                        // Welcome Text
                        Text("Custom Pop-Ups")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .shadow(radius: 5)
                            .padding(.horizontal)


                        // Action Buttons
                        VStack(spacing: 20) {
                            ActionButton(title: "Unlock", icon: "lock.open.fill", colors: [Color.blue, Color.purple]) {
                                showPasswordPrompt = true
                            }

                            ActionButton(title: "Delete", icon: "trash.fill", colors: [Color.red, Color.orange]) {
                                showConfirmationDialog = true
                            }

                            ActionButton(title: "Info", icon: "info.circle.fill", colors: [Color.green, Color.blue]) {
                                showInfoAlert = true
                            }

                            ActionButton(title: "Success", icon: "checkmark.seal.fill", colors: [Color.teal, Color.green]) {
                                showSuccessAlert = true
                            }

                            ActionButton(title: "Warning", icon: "exclamationmark.triangle.fill", colors: [Color.orange, Color.yellow]) {
                                showWarningAlert = true
                            }

                            ActionButton(title: "Custom Input", icon: "square.and.pencil", colors: [Color.purple, Color.indigo]) {
                                showCustomInputDialog = true
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)

                        Spacer(minLength: 50)
                    }
                
            }
            .navigationBarHidden(true)
        }
        // Pop-ups
        .popup(isPresented: $showPasswordPrompt) {
            PasswordPromptView(show: $showPasswordPrompt) { password in
                if password == "hello" {
                    showSuccessAlert = true
                } else {
                    showErrorAlert = true
                }
            }
        }
        .popup(isPresented: $showErrorAlert) {
            AlertView(
                show: $showErrorAlert,
                icon: "xmark.octagon.fill",
                iconColor: .red,
                title: "Error",
                message: "Incorrect password. Please try again.",
                buttonText: "OK",
                buttonColor: .red
            )
        }
        .popup(isPresented: $showSuccessAlert) {
            AlertView(
                show: $showSuccessAlert,
                icon: "checkmark.circle.fill",
                iconColor: .green,
                title: "Success",
                message: "Your action was successful!",
                buttonText: "OK",
                buttonColor: .green
            )
        }
        .popup(isPresented: $showConfirmationDialog) {
            ConfirmationDialogView(
                show: $showConfirmationDialog,
                title: "Delete Confirmation",
                message: "Are you sure you want to delete this item?",
                confirmAction: {
                    showSuccessAlert = true
                }
            )
        }
        .popup(isPresented: $showInfoAlert) {
            AlertView(
                show: $showInfoAlert,
                icon: "info.circle.fill",
                iconColor: .blue,
                title: "Information",
                message: "This is an informational message.",
                buttonText: "OK",
                buttonColor: .blue
            )
        }
        .popup(isPresented: $showWarningAlert) {
            AlertView(
                show: $showWarningAlert,
                icon: "exclamationmark.triangle.fill",
                iconColor: .orange,
                title: "Warning",
                message: "Please be cautious while proceeding.",
                buttonText: "OK",
                buttonColor: .orange
            )
        }
        .popup(isPresented: $showCustomInputDialog) {
            CustomInputDialogView(show: $showCustomInputDialog) { inputText in
                // Handle the input text as needed
                showInfoAlert = true
            }
        }
    }
}

struct ActionButton: View {
    var title: String
    var icon: String
    var colors: [Color]
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: .leading,
                endPoint: .trailing)
            )
            .cornerRadius(15)
            .shadow(color: colors.last?.opacity(0.6) ?? Color.black.opacity(0.6), radius: 5, x: 0, y: 5)
        }
    }
}

#Preview {
    CustomPopupView()
}
