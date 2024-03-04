//
//  Font.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 01.03.2024.
//

import SwiftUI

func MadimiOneFont(isBold: Bool = false, size: CGFloat) -> Font {
    if isBold {
        return Font.custom("MadimiOne-Regular", size: size, relativeTo: .title)
    } else {
        return Font.custom("MadimiOne-Regular", size: size)
    }
}
