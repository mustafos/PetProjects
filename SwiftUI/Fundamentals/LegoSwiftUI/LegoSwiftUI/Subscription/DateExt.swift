//
//  DateExt.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 31.10.2024.
//

import Foundation

extension Date {
    func isLessThen(_ date: Date) -> Bool {
        if self.timeIntervalSince(date) < date.timeIntervalSinceNow {
            return true
        } else {
            return false
        }
    }
}
