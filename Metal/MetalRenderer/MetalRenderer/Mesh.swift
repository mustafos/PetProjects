//
//  Mesh.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 11.10.2023.
//

import Foundation
import MetalKit

struct Mesh {
    
    let mtkMesh: MTKMesh
    let submeshes: [Submesh]
    
    init(mdlMesh: MDLMesh, mtkMesh: MTKMesh) {
        self.mtkMesh = mtkMesh
        submeshes = zip(mdlMesh.submeshes!, mtkMesh.submeshes).map {
            Submesh(mdlSubmesh: $0.0 as! MDLSubmesh, mtkSubmesh: $0.1)
        }
    }
}

struct Submesh {
    let mtkSubmesh: MTKSubmesh
    var material: Material
    init(mdlSubmesh: MDLSubmesh, mtkSubmesh: MTKSubmesh) {
        self.mtkSubmesh = mtkSubmesh
        material = Material(material: mdlSubmesh.material)
    }
}

private extension Material {
    init(material: MDLMaterial?) {
        self.init()
        if let baseColor = material?.property(with: .baseColor),
           baseColor.type == .float3 {
            self.baseColor = baseColor.float3Value
        }
        if let shininess = material?.property(with: .specularExponent),
           shininess.type == .float {
            self.shininess = shininess.floatValue
        }
    }
}
