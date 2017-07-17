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
    var scrollLayer: SKNode!
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
        scrollLayer = self.childNode(withName: "scrollLayer")
        building = self.childNode(withName: "building1")
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        hero = self.childNode(withName: "//hero") as!SKSpriteNode
        charState = .running

    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Process world scrolling */
        scrollWorld()
    }
    
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 100
    
    func scrollWorld() {
        /* Scroll World */
        scrollLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        /* Loop through scroll layer nodes */
        for ground in scrollLayer.children as! [SKReferenceNode] {
        
            /* Get ground node position, convert node position to scene space */
            let groundPosition = scrollLayer.convert(ground.position, to: self)
            
            /* Check if ground sprite has left the scene */
            if groundPosition.x <= -1820 / 2 {
                
                /* Reposition ground sprite to the second starting position */
                let newPosition = CGPoint(x: (self.size.width / 2) + 720, y: groundPosition.y)
                
                /* Convert new node position back to scroll layer space */
                ground.position = self.convert(newPosition, to: scrollLayer)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        /* Apply vertical impulse */
        hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
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
