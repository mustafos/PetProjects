//
//  Scene.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 28.09.2023.
//

import Foundation

class Scene {
    var rootNode = Node()
    var renderables: [Renderable] = []
    
    var sceneSize: CGSize
    
    init(sceneSize: CGSize) {
        self.sceneSize = sceneSize
        setupScene()
    }
    
    final func add(node: Node, parent: Node? = nil, render: Bool = true) {
        if let parent = parent {
            parent.add(childNode: node)
        } else {
            rootNode.add(childNode: node)
        }
        
        if render, let renderable = node as? Renderable {
            renderables.append(renderable)
        }
    }
    
    func setupScene() {
        // override this to add objects to the scene
    }
}

