//
//  AlertEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 02.05.2023.
//

import SwiftUI

struct AlertEx: View {
    @State var isError = false
    
    var body: some View {
        showAlert()
        showAlert2()
    }
    
    fileprivate func showAlert() -> some View {
        return Button {
            self.isError = true
        } label: {
            Text("Exit")
        }.alert(isPresented: $isError) {
            Alert(title: Text("Test"), message: Text("You shure?"), primaryButton: .destructive(Text("Yes"), action: {
                print("testimonio")
            }), secondaryButton: .cancel())
        }
    }
    
    fileprivate func showAlert2() -> some View {
        return Button {
            self.isError = true
        } label: {
            Text("Touch me!")
        }.actionSheet(isPresented: $isError) {
            ActionSheet(title: Text("Download"), message: Text("Do you want to download photos?"), buttons: [.default(Text("GET"), action: {
                print("Loading...")
            }), .cancel()])
        }
    }
}

struct AlertEx_Previews: PreviewProvider {
    static var previews: some View {
        AlertEx()
    }
}
