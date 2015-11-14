//
//  GameScene.swift
//  FlappyBirdClone
//
//  Created by Calvin Schofield on 11/12/15.
//  Copyright (c) 2015 Calvin Schofield. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var skyColor = SKColor(red: 180/255, green: 200/255, blue: 255/255, alpha: 1.0)
    
    var ground = SKShapeNode()
    
    var player = SKShapeNode()
    
    
    override func didMoveToView(view: SKView) {
        //Setting up Scene
        self.backgroundColor = skyColor
        
        ground = SKShapeNode(rectOfSize: CGSize(width: frame.width, height: frame.height * 0.2))
        
        ground.fillColor = SKColor.greenColor()
        
        ground.position = CGPoint(x: frame.width / 2, y: 0)
        
        addChild(ground)
        
        
        //Setting up Physics
        self.physicsWorld.contactDelegate = self
        
        physicsWorld.gravity = CGVectorMake(0, -12)
        
        
        //Setting up Player - A Basic Cricle
        player = SKShapeNode(circleOfRadius: 20)
        
        player.fillColor = SKColor.blackColor()
        
        player.strokeColor = SKColor.grayColor()
        
        player.lineWidth = 2
        
        player.position = CGPoint(x: CGRectGetMidX(self.frame) * 0.8, y: CGRectGetMidY(self.frame))
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
        player.physicsBody?.dynamic = true
        
        player.physicsBody?.allowsRotation = false
        
        addChild(player)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        player.physicsBody?.velocity = CGVectorMake(0, 0)
        
        player.physicsBody?.applyImpulse(CGVectorMake(0, 36))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
}
