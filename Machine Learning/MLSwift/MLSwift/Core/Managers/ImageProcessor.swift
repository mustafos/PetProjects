//
//  ImageProcessor.swift
//  MLSwift
//
//  Created by Mustafa Bekirov on 21.01.2025.
//

import Vision
import UIKit

class ImageProcessor {
    static func pixelBuffer(from image: UIImage) -> CVPixelBuffer? {
        let imageSize = CGSize(width: 416, height: 416) // Размер модели YOLOv3
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 2.0)
        image.draw(in: CGRect(origin: .zero, size: imageSize))
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        UIGraphicsEndImageContext()

        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue!,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue!] as CFDictionary
        
        var pixelBuffer: CVPixelBuffer?
        CVPixelBufferCreate(kCFAllocatorDefault, Int(imageSize.width), Int(imageSize.height),
                            kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)

        guard let buffer = pixelBuffer else { return nil }
        CVPixelBufferLockBaseAddress(buffer, .readOnly)

        let pixelData = CVPixelBufferGetBaseAddress(buffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context2 = CGContext(data: pixelData,
                                 width: Int(imageSize.width),
                                 height: Int(imageSize.height),
                                 bitsPerComponent: 8,
                                 bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                                 space: rgbColorSpace,
                                 bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context2?.draw(context.makeImage()!, in: CGRect(origin: .zero, size: imageSize))
        CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
        return buffer
    }
}
