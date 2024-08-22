//
//  ImageCacheTests.swift
//  PunkIPATests
//

import XCTest
@testable import PunkIPA

final class ImageCacheTests: XCTestCase {

    var sut: DefaultImageCache!

    override func setUp() {
        sut = DefaultImageCache()
    }
}

final class RandomImageProvider {
    static func makeImage() -> UIImage {
        let size = CGSize(
            width: Int.random(in: 50...300),
            height: Int.random(in: 50...300)
        )

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1
            ).setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
