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
    
    struct Textures {
        let baseColor: MTLTexture?
        
        init(material: MDLMaterial?) {
            guard let baseColor = material?.property(with: .baseColor), 
                    baseColor.type == .texture,
                    let mdlTexture = baseColor.textureSamplerValue?.texture else {
                self.baseColor = nil
                return
            }
            let textureLoader = MTKTextureLoader(device: Renderer.device)
            let textureLoaderOptions: [MTKTextureLoader.Option: Any] = [
                .origin: MTKTextureLoader.Origin.bottomLeft
            ]
            self.baseColor = try? textureLoader.newTexture(texture: mdlTexture,
                                                           options: textureLoaderOptions)
        }
    }
    
    let textures: Textures
    
    init(mdlSubmesh: MDLSubmesh, mtkSubmesh: MTKSubmesh) {
        self.mtkSubmesh = mtkSubmesh
        material = Material(material: mdlSubmesh.material)
        textures = Textures(material: mdlSubmesh.material)
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
