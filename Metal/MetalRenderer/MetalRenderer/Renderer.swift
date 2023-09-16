//
//  Renderer.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 14.09.2023.
//

import Foundation
import MetalKit

class Renderer: NSObject {
    static var device: MTLDevice!
    let commandQueue: MTLCommandQueue
    static var library: MTLLibrary!
    let pipelineState: MTLRenderPipelineState
    
    let positionArray: [float4] = [
        float4(-0.5, -0.2, 0, 1),
        float4(0.2, -0.2, 0, 1),
        float4(0, 0.5, 0, 1),
        float4(0, 0.5, 0, 1),
        float4(0.2, -0.2, 0, 1),
        float4(0.7, 0.7, 0, 1),
    ]
    
    let colorArray: [float3] = [
        float3(1, 0, 0),
        float3(0, 1, 0),
        float3(0, 0, 1),
        float3(0, 0, 1),
        float3(0, 1, 0),
        float3(1, 0, 1),
    ]
    
    let positionBuffer: MTLBuffer
    let colorBuffer: MTLBuffer
    
    var timer: Float = 0
    
    init(view: MTKView) {
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue() else {
            fatalError("Unable to connect to GPU")
        }
        Renderer.device = device
        self.commandQueue = commandQueue
        Renderer.library = device.makeDefaultLibrary()!
        pipelineState = Renderer.createPipelineState()
        
        let positionLength = MemoryLayout<float4>.stride * positionArray.count
        positionBuffer = device.makeBuffer(bytes: positionArray, length: positionLength, options: [])!
        let colorLength = MemoryLayout<float3>.stride * colorArray.count
        colorBuffer = device.makeBuffer(bytes: colorArray, length: colorLength, options: [])!
        super.init()
    }
    
    static func createPipelineState() -> MTLRenderPipelineState {
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        
        // pipeline state properties
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        let vertexFunction = Renderer.library.makeFunction(name: "vertex_main")
        let fragmentFunction = Renderer.library.makeFunction(name: "fragment_main")
        pipelineStateDescriptor.fragmentFunction = fragmentFunction
        
        return try! Renderer.device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    func draw(in view: MTKView) {
        guard let commandBuffer = commandQueue.makeCommandBuffer(),
                let drawable = view.currentDrawable,
              let descriptor = view.currentRenderPassDescriptor,
              let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor)  else {
            return
        }
        
        timer += 0.05
        var currentTime = sin(timer)
        
        commandEncoder.setVertexBytes(&currentTime,
                                      length: MemoryLayout<Float>.stride,
                                      index: 2)
        commandEncoder.setRenderPipelineState(pipelineState)
        
        commandEncoder.setVertexBuffer(positionBuffer, offset: 0, index: 0)
        commandEncoder.setVertexBuffer(colorBuffer, offset: 0, index: 1)
        
        // draw call
        commandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6)
        commandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
