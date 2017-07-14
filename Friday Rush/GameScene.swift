//
//  GameScene.swift
//  Friday Rush
//
//  Created by Diego Lucero on 7/13/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

enum state {
    case running, jumping
}

switch state {
case .running:
    
default:
    break
}

class GameScene: SKScene {
    var ground: SKReferenceNode!
    var building: SKReferenceNode!
    
    override func didMove(to view: SKView) {
        ground = self.childNode(withName: "ground") as!SKReferenceNode
        building = self.childNode(withName: "building") as! SKReferenceNode
        
    }
}
