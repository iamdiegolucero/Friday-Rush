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
    var spawnTimer: CFTimeInterval = 0
    let impulse: Int = 900
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
        /* Set reference to obstacle Source node */
        obstacleSource = self.childNode(withName: "obstacle")
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        charState = .running

    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        /* Grab current velocity */
        let velocityY = hero.physicsBody?.velocity.dy ?? 0
        
        /* Check and cap vertical velocity */
        if velocityY > 900 {
            hero.physicsBody?.velocity.dy = 900
        }
        
        /* Process world scrolling */
        scrollWorld()
        updateObstacles()
        spawnTimer+=fixedDelta
    }
    
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 350
    
    
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
        if charState != .jumping{
            hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: impulse))
        }
    }
    
    
    func updateObstacles() {
        /* Update Obstacles */
        
        obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        /* Loop through obstacle layer nodes */
        for obstacle in obstacleLayer.children as! [SKNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let obstaclePosition = obstacleLayer.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the scene */
            if obstaclePosition.x <= -1820 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                obstacle.removeFromParent()
            }
            
        }
        /* Time to add a new obstacle? */
        if spawnTimer >= 1.2 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newObstacle = obstacleSource.copy() as! SKNode
            obstacleLayer.addChild(newObstacle)
            
            /* Generate new obstacle position, start just outside screen and with a random y value */
            let randomPosition = CGPoint(x: 352, y: -212)
            
            /* Convert new node position back to obstacle layer space */
            newObstacle.position = self.convert(randomPosition, to: obstacleLayer)
            
            // Reset spawn timer
            spawnTimer = 0
        }
    }
}
