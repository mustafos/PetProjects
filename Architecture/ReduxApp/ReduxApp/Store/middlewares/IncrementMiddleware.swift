//
//  IncrementMiddleware.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 04.01.2025.
//

import Foundation
func incrementMiddleware() -> Middlewere<AppState> {
    return { state, action, dispatch in
        switch action {
        case _ as IncrementAsyncAction:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                dispatch(IncrementAction())
            }
        default:
            break
        }
    }
}
