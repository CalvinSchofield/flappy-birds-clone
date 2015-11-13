//
//  GameScene.swift
//  FlappyBirdClone
//
//  Created by Calvin Schofield on 11/12/15.
//  Copyright (c) 2015 Calvin Schofield. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var skyColor = SKColor(red: 250/255, green: 255/255, blue: 245/255, alpha: 1.0)
    
    var player = SKShapeNode()
    
    var gameStart = false
    
    var count = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = skyColor
        
        self.physicsWorld.contactDelegate = self
        
        physicsWorld.gravity = CGVectorMake(0, -20)
        
        let borderFrame = SKPhysicsBody.init(edgeLoopFromRect: frame)
        
        physicsBody = borderFrame
        
        player = SKShapeNode(circleOfRadius: 20)
        
        player.position = CGPoint(x: CGRectGetMidX(self.frame) - 50, y: CGRectGetMidY(self.frame))
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
        if gameStart && count > 0 {
        
            player.physicsBody?.dynamic = true
        
            player.physicsBody?.allowsRotation = false
            
            gameStart = false
            
        } else {
            
            player.physicsBody?.dynamic = false
            
            player.physicsBody?.allowsRotation = false
            
            gameStart = true
            
        }
        
        addChild(player)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        count++
        
        player.physicsBody?.velocity = CGVectorMake(0, 0)
        
        player.physicsBody?.applyImpulse(CGVectorMake(0, 55))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
}
