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
    private var fatState: SKAction!
    private var slimState: SKAction!
    private var eatState: SKAction!
    private var deathSkullState: SKAction!
    private var deathExplosionState: SKAction!
    private var weight: Int = 4
    private var silhuet: String!
    
    var isDead: Bool!
    
    //Instatiate the object with position as parameter
    init(position: CGPoint) {
        isDead = false
        self.silhuet = "normal"
        super.init(texture: SKTexture(imageNamed: "normal_Idle1"), color: UIColor.clearColor(), size: CGSizeMake(50, 50))
        self.position = position
        self.physicsBody = self.generatePhysicsBody()
        self.initializeAnimations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getWeight() -> Int {
        return self.weight
    }
    
    func changeWeight(weight: Int){
        self.weight = weight + self.weight
        
        if self.weight <= 0 && isDead != true {
            self.silhuet = "esqueleto"
            self.deathSkullState = self.deathSkullGuy()
            isDead = true
            self.userInteractionEnabled = false
    
        }else if self.weight < 4 && self.weight > 0 && isDead != true {
            self.silhuet = "magro"
            self.slimState = self.slimGuy()
            
        } else if (self.weight >= 4 && self.weight < 8 && isDead != true ) {
            silhuet = "normal"
        }
        else if self.weight > 7 && self.weight <= 10 && isDead != true {
            self.silhuet = "gordo"
            self.fatState = self.fatguy()

        } else if self.weight > 10 && isDead != true {
            self.silhuet = "explosao"
            self.deathExplosionState = self.deathExplosionGuy()
            self.isDead = true
            self.position.x = self.position.x//stop player moviment
            self.userInteractionEnabled = false
        }
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
    
    
    //fatanimation
    
    private func fatguy()-> SKAction{
        let silhuet = self.silhuet
        var fatTextures: [SKTexture] = []
        
        for i in 1 ... 2 {
            fatTextures.append(SKTexture(imageNamed: "\(silhuet)_getGordo\(i)"))
        }
        
        let fating = SKAction.animateWithTextures(fatTextures, timePerFrame: 0.5)
        
        return fating
        
    }
    
    
    private func slimGuy()-> SKAction{
        let silhuet = self.silhuet
        var slimTextures: [SKTexture] = []
        
        for i in 1 ... 2 {
            slimTextures.append(SKTexture(imageNamed: "\(silhuet)_Idle\(i)"))
        }
        
        let slim = SKAction.animateWithTextures(slimTextures, timePerFrame: 0.5)
        
        return slim
        
    }
    
    private func deathSkullGuy()-> SKAction{
        let silhuet = self.silhuet
        var deathSkullTextures: [SKTexture] = []
        
        for i in 1 ... 2 {
            deathSkullTextures.append(SKTexture(imageNamed: "\(silhuet)Skull\(i)"))
        }
        
        let skull = SKAction.animateWithTextures(deathSkullTextures, timePerFrame: 0.5)
        
        return skull
        
    }
    
    private func deathExplosionGuy()-> SKAction{
        let silhuet = self.silhuet
        var deathExplosionTextures: [SKTexture] = []
        
        for i in 1 ... 7 {
            deathExplosionTextures.append(SKTexture(imageNamed: "\(silhuet)_eat\(i)"))
        }
        
        let explosion = SKAction.animateWithTextures(deathExplosionTextures, timePerFrame: 0.5)
        
        return explosion
        
    }
    
    
    //Initialize the animations
    private func initializeAnimations() {
        self.eatState = self.loadEatingAnimation()
        self.idleState = self.loadIdleAnimation()
        self.runState = self.loadRunningAnimation()
        self.deathExplosionState = self.deathExplosionGuy()
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
    
    func exploding() -> SKAction{
        return self.deathExplosionState
    }
    
    //MARK: Object Physics
    override func generatePhysicsBody() -> SKPhysicsBody {
        
        let physicsBody = SKPhysicsBody.init(circleOfRadius: self.size.width/3)
        physicsBody.categoryBitMask = PhysicsCategory.Player
        physicsBody.contactTestBitMask = PhysicsCategory.Food
        physicsBody.mass = 20000
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        
        return physicsBody
    }
    
    

}
