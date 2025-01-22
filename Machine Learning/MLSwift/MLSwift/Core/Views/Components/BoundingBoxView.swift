//
//  BoundingBoxView.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 22.01.2025.
//

import SwiftUI

struct BoundingBoxView: View {
    var boundingBox: CGRect
    var imageSize: CGSize
    var viewSize: CGSize

    var body: some View {
        let x = boundingBox.minX * viewSize.width
        let y = (1 - boundingBox.maxY) * viewSize.height
        let width = boundingBox.width * viewSize.width
        let height = boundingBox.height * viewSize.height

        return Rectangle()
            .stroke(Color.red, lineWidth: 2)
            .frame(width: width, height: height)
            .position(x: x + width / 2, y: y + height / 2)
    }
}
