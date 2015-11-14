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
    
    var upperPipe = SKShapeNode()
    
    var lowerPipe = SKShapeNode()
    
    var player = SKShapeNode()
    
    var VerticalDifference : CGFloat = 5.0
    
    var gameStarted = false
    
    var clickCounter = 0
    
    
    override func didMoveToView(view: SKView) {
        //Setting up Scene
        self.backgroundColor = skyColor
        
        
        //Setting up Physics
        self.physicsWorld.contactDelegate = self
        
        physicsWorld.gravity = CGVectorMake(0, -14)
        
        
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
        
        
        //Setting up upperPipes
        upperPipe = SKShapeNode(rectOfSize: CGSize(width: 80, height: 400), cornerRadius: 15)
        
        upperPipe.fillColor = SKColor.redColor()
        
        upperPipe.strokeColor = SKColor.grayColor()
        
        upperPipe.position = CGPoint(x: frame.width * 0.6, y: frame.height * 0.8)
        
        addChild(upperPipe)
        
        
        //Setting up lowerPipes
        upperPipe = SKShapeNode(rectOfSize: CGSize(width: 80, height: 400), cornerRadius: 15)
        
        upperPipe.fillColor = SKColor.redColor()
        
        upperPipe.strokeColor = SKColor.grayColor()
        
        upperPipe.position = CGPoint(x: upperPipe.position.x, y: upperPipe.position.y - VerticalDifference)
        
        addChild(upperPipe)
        
        
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
