//
//  GameScene.swift
//  Friday Rush
//
//  Created by Diego Lucero on 7/13/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ground: SKReferenceNode!
    var building: SKReferenceNode!
    var obstacleSource: SKNode!
    var obstacleLayer: SKNode!
    
    override func didMove(to view: SKView) {
        ground = self.childNode(withName: "ground") as!SKReferenceNode
        building = self.childNode(withName: "building") as! SKReferenceNode
        obstacleLayer = self.childNode(withName: "obstacleLayer")
    }
}

func updateObstacles() {
    /* Update Obstacles */
    
    obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
    
    /* Loop through obstacle layer nodes */
    for obstacle in obstacleLayer.children as! [SKReferenceNode] {
        
        /* Get obstacle node position, convert node position to scene space */
        let obstaclePosition = obstacleLayer.convert(obstacle.position, to: self)
        
        /* Check if obstacle has left the scene */
        if obstaclePosition.x <= -26 {
            // 26 is one half the width of an obstacle
            
            /* Remove obstacle node from obstacle layer */
            obstacle.removeFromParent()
        }
        
}
