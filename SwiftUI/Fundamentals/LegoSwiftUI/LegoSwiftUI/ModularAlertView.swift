//
//  ModularAlertView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 31.03.2024.
//

import SwiftUI

struct ModularAlertView: View {
    @State private var presentAlert: Bool = false
    
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    presentAlert.toggle()
                }
            } label: {
                Text("Show Custom Alert")
            }
            
            if presentAlert {
                CustomAlertDialog(title: "Error", message: "Please confirm that you're still open to session requests then you will find the call from new user.")
                    .makeButtonsVertical(true)
                    .onNegativeButtonTap {
                        presentAlert.toggle()
                    }
                    .onPositiveButtonTap {
                        presentAlert.toggle()
                    }
            }
        }
    }
}

#Preview {
    ModularAlertView()
}

struct CustomAlertDialog: View {
    var title: String
    var message: String
    
    var positiveButtonTitle: String? = "OK"
    var negativeButtonTitle: String? = "Cancel"
    
    private var positiveButtonAction: (() -> ())? = {}
    private var negativeButtonAction: (() -> ())? = {}
    
    private var isShowVerticalButtons = false
    private let verticleButtonHeight: CGFloat = 80
    
    init(title: String, message: String, positiveButtonTitle: String? = "OK", negativeButtonTitle: String? = "Cancel", positiveButtonAction: (() -> Void)? = nil, negativeButtonAction: (() -> Void)? = nil, isShowVerticalButtons: Bool = false) {
        self.title = title
        self.message = message
        self.positiveButtonTitle = positiveButtonTitle
        self.negativeButtonTitle = negativeButtonTitle
        self.positiveButtonAction = positiveButtonAction
        self.negativeButtonAction = negativeButtonAction
        self.isShowVerticalButtons = isShowVerticalButtons
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HeaderView()
                FooterView()
            }
            .frame(width: 270, height:  isShowVerticalButtons ? 220 : 150)
            .background(Color.white)
            .cornerRadius(4)
        }
        .zIndex(2)
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        Text(title)
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
            .frame(height: 25)
            .padding(.top, 16)
            .padding(.bottom, 8)
            .padding(.horizontal, 16)
        
        Text(message)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .font(.system(size: 14))
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .minimumScaleFactor(0.5)
        
        Divider()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
            .padding(.all, 0)
    }
    
    @ViewBuilder
    private func FooterView() -> some View {
        let buttonLayout = isShowVerticalButtons ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
        buttonLayout {
            if isShowVerticalButtons {
                Spacer()
            }
            
            Button {
                negativeButtonAction?()
            } label: {
                Text(negativeButtonTitle ?? "")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            
            if isShowVerticalButtons {
                Spacer()
                Divider()
                Spacer()
            } else {
                Divider()
                    .frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)
            }
            
            Button {
                positiveButtonAction?()
            } label: {
                Text(positiveButtonTitle ?? "")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding(15)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            
            if isShowVerticalButtons {
                Spacer()
            }
        }
        .padding([.horizontal, .bottom], 0)
    }
}

extension CustomAlertDialog {
    func makeButtonsVertical(_ isVertical: Bool) -> Self {
        var alert = self
        alert.isShowVerticalButtons = isVertical
        return alert
    }
    
    func onPositiveButtonTap(_ positiveButtonAction: (() -> ())?) -> Self {
        var alert = self
        alert.positiveButtonAction = positiveButtonAction
        return alert
    }
    
    func onNegativeButtonTap(_ negativeButtonAction: (() -> ())?) -> Self {
        var alert = self
        alert.negativeButtonAction = negativeButtonAction
        return alert
    }
}
