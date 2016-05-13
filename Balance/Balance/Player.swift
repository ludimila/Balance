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
    
    private var idleState: SKAction!
    private var runState: SKAction!
    private var eatState: SKAction!
    private var weight: Int = 4
    private var silhuet: String!
    
    //Instatiate the object with position as parameter
    init(position: CGPoint) {
        self.silhuet = "normal"
        super.init(texture: SKTexture(imageNamed: "normal_Idle1"), color: UIColor.clearColor(), size: CGSizeMake(50, 50))
        self.position = position
        self.physicsBody = self.generatePhysicsBody()
        self.initializeAnimations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeWeight(weight: Int){
        self.weight += weight
        if weight < 4 {
            silhuet = "magro"
        } else if weight >= 4 && weight < 7 {
            silhuet = "normal"
        }
        else if weight > 7 {
            silhuet = "gordo"
        }
        
        print(silhuet)
        
        self.initializeAnimations()
    }
    
    //MARK: Animations
    
    //Preparing Idle Animation
    private func loadIdleAnimation() -> SKAction {
        let silhuet = self.silhuet
        var idleTextures: [SKTexture] = []
        
        for i in 1 ... 2 {
            idleTextures.append(SKTexture(imageNamed: "\(silhuet)_Idle\(i)"))
        }
        
        let idle = SKAction.animateWithTextures(idleTextures, timePerFrame: 0.5)
        
        return idle
    }
    
    //Prepare Eating Animation
    private func loadEatingAnimation() -> SKAction {
        let silhuet = self.silhuet
        var eatingTextures: [SKTexture] = []
        
        for i in 1 ... 2 {
            eatingTextures.append(SKTexture(imageNamed: "\(silhuet)_eat\(i)"))
        }
        
        let eating = SKAction.animateWithTextures(eatingTextures, timePerFrame: 0.05)
        
        return eating
    }
    
    private func loadRunningAnimation() -> SKAction {
        let silhuet = self.silhuet
        var runningTextures: [SKTexture] = []
        
        for i in 1 ... 2 {
            runningTextures.append(SKTexture(imageNamed: "\(silhuet)_Idle\(i)"))
        }
        
        let running = SKAction.animateWithTextures(runningTextures, timePerFrame: 0.5)
        
        return running
    }
    
    //Initialize the animations
    private func initializeAnimations() {
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
