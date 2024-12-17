//
//  LogMiddleware.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 04.01.2025.
//

import Foundation

func logMiddleware() -> Middlewere<AppState> {
    
    return { state, action, dispatch in
        print("LOG MIDDLEWARE")
    }
}
