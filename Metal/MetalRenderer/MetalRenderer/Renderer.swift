//
//  Renderer.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 14.09.2023.
//

import Foundation
import MetalKit

struct Vertex {
    let position: float3
    let color: float3
}

class Renderer: NSObject {
    
    static var device: MTLDevice!
    let commandQueue: MTLCommandQueue
    
    static var library: MTLLibrary!
    let pipelineState: MTLRenderPipelineState
    let depthStencilState: MTLDepthStencilState
    
    weak var scene: Scene?
    
    let camera = ArcballCamera()
    var uniforms = Uniforms()
    var fragmentUniforms = FragmentUniforms()
    
    var timer: Float = 0
    
    init(view: MTKView) {
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue() else {
            fatalError("Unable to connect to GPU")
        }
        Renderer.device = device
        self.commandQueue = commandQueue
        Renderer.library = device.makeDefaultLibrary()
        pipelineState = Renderer.createPipelineState()
        depthStencilState = Renderer.createDepthState()
        
        camera.target = [0, 0.8, 0]
        camera.distance = 3
        
        view.depthStencilPixelFormat = .depth32Float
        
        super.init()
    }
    
    static func createPipelineState() -> MTLRenderPipelineState {
        let vertexFunction = Renderer.library.makeFunction(name: "vertex_main")
        let fragmentFunction = Renderer.library.makeFunction(name: "fragment_main")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.vertexDescriptor = MTLVertexDescriptor.defaultVertexDescriptor()
        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        
        return try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
    
    static func createDepthState() -> MTLDepthStencilState {
        let depthDescriptor = MTLDepthStencilDescriptor()
        depthDescriptor.depthCompareFunction = .less
        depthDescriptor.isDepthWriteEnabled = true
        return Renderer.device.makeDepthStencilState(descriptor: depthDescriptor)!
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        camera.aspect = Float(view.bounds.width / view.bounds.height)
    }
    
    func draw(in view: MTKView) {
        guard let commandBuffer = commandQueue.makeCommandBuffer(),
              let drawable = view.currentDrawable,
              let descriptor = view.currentRenderPassDescriptor,
              let scene = scene else {
            return
        }
        
        let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor)!
        commandEncoder.setRenderPipelineState(pipelineState)
        
        uniforms.viewMatrix = camera.viewMatrix
        uniforms.projectionMatrix = camera.projectionMatrix
        
        fragmentUniforms.cameraPosition = camera.position
        commandEncoder.setFragmentBytes(&fragmentUniforms,
                                        length: MemoryLayout<FragmentUniforms>.stride,
                                        index: 22)
        
        commandEncoder.setDepthStencilState(depthStencilState)
        
        for renderable in scene.renderables {
            commandEncoder.pushDebugGroup(renderable.name)
            renderable.render(commandEncoder: commandEncoder,
                              uniforms: uniforms)
            commandEncoder.popDebugGroup()
        }
        
        commandEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
