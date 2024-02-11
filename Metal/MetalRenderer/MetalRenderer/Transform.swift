//
//  Transform.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 17.09.2023.
//

import Foundation
import simd

struct Transform {
    var position = float3(0)
    var rotation = float3(0)
    var scale: Float = 1
    
    var matrix: float4x4  {
        let translateMatrix = float4x4(translation: position)
        let rotationMatrix = float4x4(rotation: rotation)
        let scaleMatrix = float4x4(scaling: scale)
        return translateMatrix * scaleMatrix * rotationMatrix
    }
}
