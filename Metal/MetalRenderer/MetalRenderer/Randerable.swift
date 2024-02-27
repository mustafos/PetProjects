//
//  Randerable.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 28.09.2023.
//

import Foundation
import MetalKit

protocol Renderable {
    var name: String { get }
    func render(commandEncoder: MTLRenderCommandEncoder,
                uniforms vertex: Uniforms)
}
