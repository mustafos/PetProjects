//
//  Model.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 16.09.2023.
//

import Foundation
import MetalKit

class Model: Node {
    
    let meshes: [Mesh]
    
    init(name: String) {
        let assetUrl = Bundle.main.url(forResource: name, withExtension: "obj")
        let allocator = MTKMeshBufferAllocator(device: Renderer.device)
        
        let vertexDescriptor = MDLVertexDescriptor.defaultVertexDescriptor()
        let asset = MDLAsset(url: assetUrl, vertexDescriptor: vertexDescriptor, bufferAllocator: allocator)
        
        let (mdlMeshes, mtkMeshes) = try! MTKMesh.newMeshes(asset: asset, device: Renderer.device)
        
        meshes = zip(mdlMeshes, mtkMeshes).map {
            Mesh(mdlMesh: $0.0, mtkMesh: $0.1)
        }
        
        super.init()
        self.name = name
    }
}

extension Model: Renderable {
    func render(commandEncoder: MTLRenderCommandEncoder, uniforms vertex: Uniforms) {
        var uniforms = vertex
        
        uniforms.modelMatrix = worldMatrix
        commandEncoder.setVertexBytes(&uniforms,
                                      length: MemoryLayout<Uniforms>.stride,
                                      index: 21)
        
        for mesh in meshes {
            for vertexBuffer in mesh.mtkMesh.vertexBuffers {
                
                commandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: 0, index: 0)
                
                for submesh in mesh.submeshes {
                    
                    var material = submesh.material
                    commandEncoder.setFragmentBytes(&material,
                                                    length: MemoryLayout<Material>.stride,
                                                    index: 11)
                   
                    let mtkSubmesh = submesh.mtkSubmesh
                    
                    commandEncoder.drawIndexedPrimitives(type: .triangle,
                                                         indexCount: mtkSubmesh.indexCount,
                                                         indexType: mtkSubmesh.indexType,
                                                         indexBuffer: mtkSubmesh.indexBuffer.buffer,
                                                         indexBufferOffset: mtkSubmesh.indexBuffer.offset)
                }
            }
        }
    }
}
