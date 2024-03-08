//
//  ErrorScreens.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 07.03.2024.
//

import SwiftUI

struct ErrorScreens: View {
    private let randomNumber = Int.random(in: 1...3)
    var errorType: ErrorType
    var buttonText: String
    var action: () -> ()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                /*If have the same name image*/
                //Image(errorType.rawValue)
                Image("\(randomNumber)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(getTitle())
                    .font(MadimiOneFont(isBold: true, size: 32))
                    .padding(.top, 30)
                
                Text(getCaption())
                    .font(MadimiOneFont(size: 18))
                    .opacity(0.5)
                    .padding([.leading, .trailing], 50)
                
                Spacer()
                
                Button {
                    action()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.gray)
                        .overlay {
                            Text(buttonText)
                                .font(MadimiOneFont(size: 18))
                                .foregroundStyle(.white)
                        }
                }
                .frame(height: 70)
                .padding([.leading, .trailing], 20)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private func getTitle() -> String {
        switch(errorType) {
        case .ConnectionFailed:
            return connectionFailedTitle
        case .BrokenLink:
            return brokenLinkTitle
        case .NoResult:
            return noResultTitle
        case .NotEnoughSpace:
            return notEnoughSpaceTitle
        case .Opps:
            return oppsTitle
        case .PageNotFound:
            return pageNotFoundTitle
        }
    }
    
    private func getCaption() -> String {
        switch(errorType) {
        case .ConnectionFailed:
            return connectionFailedCaption
        case .BrokenLink:
            return brokenLinkCaption
        case .NoResult:
            return noResultCaption
        case .NotEnoughSpace:
            return notEnoughSpaceCaption
        case .Opps:
            return oppsCaption
        case .PageNotFound:
            return pageNotFoundCaption
        }
    }
}

#Preview {
    ErrorScreens(errorType: .BrokenLink, buttonText: "Go Back") {
        
    }
}

let connectionFailedTitle = "ConnectionFailed"
let brokenLinkTitle = "BrokenLink"
let noResultTitle = "NoResult"
let notEnoughSpaceTitle = "NotEnoughSpace"
let oppsTitle = "Opps"
let pageNotFoundTitle = "PageNotFound"

let connectionFailedCaption = "Could not connect to the network, Please check and try again"
let brokenLinkCaption = "Something went wrong, please Try again later"
let noResultCaption = "Sorry there are no results for this search. Please try another"
let notEnoughSpaceCaption = "You do not have enough storage left to save this file"
let oppsCaption = "Something wrong with your connection, please try again"
let pageNotFoundCaption = "The page you are looking for doesn't seem to exit..."
