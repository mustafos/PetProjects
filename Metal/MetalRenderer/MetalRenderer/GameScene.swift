//
//  GameScene.swift
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 28.09.2023.
//

import Foundation

class GameScene: Scene {
    let train = Model(name: "train")
    let tree = Model(name: "treefir")
    
    override func setupScene() {
        add(node: train)
        add(node: tree)
        tree.position.x = -2.0
    }
}
