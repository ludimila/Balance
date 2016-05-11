//
//  Player.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class Player: GameObject {
    
    var idleState: SKAction!
    var runState: SKAction!
    var eatState: SKAction!
    
    //Instatiate the object with position as parameter
    init(position: CGPoint) {
        super.init(texture: SKTexture(imageNamed: "idle"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "idle").size())
        self.position = position
        self.physicsBody = self.generatePhysicsBody()
        self.initializeAnimations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Animations
    
    //Preparing Idle Animation
    func loadIdleAnimation() -> SKAction {
        var idleTextures: [SKTexture] = []
        
        for i in 1 ... 5 {
            idleTextures.append(SKTexture(imageNamed: "idle\(i)"))
        }
        
        let idle = SKAction.animateWithTextures(idleTextures, timePerFrame: 0.5)
        
        return idle
    }
    
    //Prepare Eating Animation
    func loadEatingAnimation() -> SKAction {
        var eatingTextures: [SKTexture] = []
        
        for i in 1 ... 5 {
            eatingTextures.append(SKTexture(imageNamed: "eating\(i)"))
        }
        
        let eating = SKAction.animateWithTextures(eatingTextures, timePerFrame: 0.5)
        
        return eating
    }
    
    func loadRunningAnimation() -> SKAction {
        var runningTextures: [SKTexture] = []
        
        for i in 1 ... 5 {
            runningTextures.append(SKTexture(imageNamed: "running\(i)"))
        }
        
        let running = SKAction.animateWithTextures(runningTextures, timePerFrame: 0.5)
        
        return running
    }
    
    //Initialize the animations
    func initializeAnimations() {
        self.eatState = self.loadEatingAnimation()
        self.idleState = self.loadIdleAnimation()
        self.runState = self.loadRunningAnimation()
    }
    
    //MARK: Player Actions
    
    func idle() -> SKAction {
        let repeatForever = SKAction.repeatActionForever(self.idleState)
        
        return repeatForever
    }
    
    func running() -> SKAction {
        let repeatForever = SKAction.repeatActionForever(self.runState)
        
        return repeatForever
    }
    
    func eating() -> SKAction {
        self.removeActionForKey("currentAnimation")
        
        return self.eatState
    }
    
    //MARK: Object Physics
    override func generatePhysicsBody() -> SKPhysicsBody {
        
        let physicsBody = SKPhysicsBody.init(rectangleOfSize: self.size)
        physicsBody.categoryBitMask = PhysicsCategory.Player
        physicsBody.contactTestBitMask = PhysicsCategory.Food
        physicsBody.mass = 20000
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        
        return physicsBody
    }
    
    

}
