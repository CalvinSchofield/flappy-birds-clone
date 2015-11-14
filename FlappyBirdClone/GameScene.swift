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
    
    var pipe = SKShapeNode()
    
    var player = SKShapeNode()
    
    var movePipes = SKAction()
    
    var gameStarted = false
    
    var clickCounter = 0
    
    
    override func didMoveToView(view: SKView) {
        //Setting up Scene
        self.backgroundColor = skyColor
        
        
        //Setting up Ground
        ground = SKShapeNode(rectOfSize: CGSize(width: frame.width, height: frame.height * 0.2))
        
        ground.fillColor = SKColor.greenColor()
        
        ground.position = CGPoint(x: frame.width / 2, y: 0)
        
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: frame.width, height: frame.height * 0.2))
        
        if let physics = ground.physicsBody {
            
            physics.dynamic = false
            
            physics.allowsRotation = false
            
            physics.affectedByGravity = false
            
        }
        
        addChild(ground)
        
        
        //Setting up Pipes
        pipe = SKShapeNode(rectOfSize: CGSize(width: 80, height: 800), cornerRadius: 10)
        
        pipe.fillColor = SKColor.redColor()
        
        pipe.strokeColor = SKColor.grayColor()
        
        pipe.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        addChild(pipe)
        
        
        //Setting up Physics
        self.physicsWorld.contactDelegate = self
        
        physicsWorld.gravity = CGVectorMake(0, -12)
        
        
        //Setting up Player - A Basic Cricle
        player = SKShapeNode(circleOfRadius: 20)
        
        player.fillColor = SKColor.blackColor()
        
        player.strokeColor = SKColor.grayColor()
        
        player.lineWidth = 2
        
        player.position = CGPoint(x: CGRectGetMidX(self.frame) * 0.8, y: CGRectGetMidY(self.frame))
        
        addChild(player)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        if clickCounter >= 0 {
            
            setPhysics()
        
            player.physicsBody?.velocity = CGVectorMake(0, 0)
        
            player.physicsBody?.applyImpulse(CGVectorMake(0, 36))
            
        } else {
            
            clickCounter++
            
            gameStarted = true
            
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
    
    //MARK: - Function : check for gameState
    func setPhysics() {
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
        if gameStarted {
            
            if let physics = player.physicsBody {
                
                physics.dynamic = true
                
                physics.allowsRotation = false
                
                physics.affectedByGravity = true
                
            }
            
        }
        
    }
    
    
}
