//
//  GameScene.swift
//  Friday Rush
//
//  Created by Diego Lucero on 7/13/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

enum CharacterState {
    case running, jumping
}

class GameScene: SKScene {
    var ground: SKNode!
    var building: SKNode!
    var obstacleSource: SKNode!
    var obstacleLayer: SKNode!
    var hero: SKSpriteNode!
    var charState: CharacterState = .running {
        didSet {
            switch charState {
            case .running:
                let move = SKAction(named: "Move")
                let sequence = SKAction.repeatForever(move!)
                hero.run(sequence)
            case .jumping:
                break
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        ground = self.childNode(withName: "ground")
        building = self.childNode(withName: "building1")
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        hero = self.childNode(withName: "hero") as!SKSpriteNode
        charState = .running

    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}


//func updateObstacles() {
//    /* Update Obstacles */
//    
//    obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
//    
//    /* Loop through obstacle layer nodes */
//    for obstacle in obstacleLayer.children as! [SKReferenceNode] {
//        
//        /* Get obstacle node position, convert node position to scene space */
//        let obstaclePosition = obstacleLayer.convert(obstacle.position, to: self)
//        
//        /* Check if obstacle has left the scene */
//        if obstaclePosition.x <= -26 {
//            // 26 is one half the width of an obstacle
//            
//            /* Remove obstacle node from obstacle layer */
//            obstacle.removeFromParent()
//        }
//        
//}
