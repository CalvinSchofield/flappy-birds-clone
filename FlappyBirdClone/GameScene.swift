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
    
    var moveNode = SKNode()
    
    var ground = SKShapeNode()
    
    var pipeDown = SKShapeNode()
    
    var pipeUp = SKShapeNode()
    
    var pipes = SKNode()
    
    var player = SKShapeNode()
    
    var movePipes = SKAction()
    
    var movePipesAndRemove = SKAction()
    
    let verticalPipeGap = 150.0
    
    var gameStarted = false
    
    var clickCounter = 0
    
    
    override func didMoveToView(view: SKView) {
        //Setting up Scene
        self.backgroundColor = skyColor
        
        
        //Preparing for Moving Methods
        moveNode.addChild(pipes)
        
        
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
        
        
        //Creating the Pipe's movement actions
        movePipesAndRemove = SKAction()
        
        let distanceToMove = CGFloat(self.frame.size.width + 2.0 * pipeUp.frame.size.width)
        
        let movePipes = SKAction.moveByX(-distanceToMove, y:0.0, duration:NSTimeInterval(0.01 * distanceToMove))
        
        let removePipes = SKAction.removeFromParent()
        
        movePipesAndRemove = SKAction.sequence([movePipes, removePipes])
        
        
        //Spawn the Pipes
        let spawn = SKAction.runBlock({() in self.spawnPipes()})
        
        let delay = SKAction.waitForDuration(NSTimeInterval(2.0))
        
        let spawnThenDelay = SKAction.sequence([spawn, delay])
        
        let spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay)
        
        self.runAction(spawnThenDelayForever)
        
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
    
    
    //MARK: - Function : spawn pipes
    func spawnPipes() {
        
        let pipePair = SKNode()
        
        pipePair.position = CGPoint(x: self.frame.size.width + pipeDown.frame.size.width * 2, y: 0)
        
        pipePair.zPosition = -10
        
        let height = UInt32(self.frame.size.height / 4)
        
        let y = Double(arc4random_uniform(height) + height);
        
        
        //Setting up Pipes
        pipeDown = SKShapeNode(rectOfSize: CGSize(width: 80, height: 800), cornerRadius: 10)
        
        pipeDown.fillColor = SKColor.redColor()
        
        pipeDown.strokeColor = SKColor.grayColor()
        
        pipeDown.position = CGPoint(x: 0.0, y: y + Double(pipeDown.frame.size.height) + verticalPipeGap)
        
        pipePair.addChild(pipeDown)
        
        
        pipeUp = SKShapeNode(rectOfSize: CGSize(width: 80, height: 800), cornerRadius: 10)
        
        pipeUp.position = CGPoint(x: 0.0, y: y)
        
        pipeUp.physicsBody = SKPhysicsBody(rectangleOfSize: pipeUp.frame.size)
        
        pipeUp.physicsBody?.dynamic = false
        
        pipePair.addChild(pipeUp)
        
        
        //Setting up the contact        
        pipePair.runAction(movePipesAndRemove)
        pipes.addChild(pipePair)
        
    }
    
}
