//
//  Camera.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 24.09.2023.
//

import Foundation
import MetalKit

class Camera {
    var transform = Transform()
    
    var viewMatrix: float4x4 {
        let translateMatrix = float4x4(translation: transform.position)
        let rotateMatrix = float4x4(rotation: transform.rotation)
        let scaleMatrix = float4x4(scaling: transform.scale)
        return (translateMatrix * scaleMatrix * rotateMatrix).inverse
    }
    
    var fov = radians(fromDegrees: 60)
    var near: Float = 0.01
    var far: Float = 100
    var aspect: Float = 1
    
    var projectionMatrix: float4x4 {
        return float4x4(projectionFov: fov, near: near, far: far, aspect: aspect)
    }
}
