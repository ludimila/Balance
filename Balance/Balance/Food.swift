//
//  Food.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class Food: GameObject {
    
    var weight: Int = 0
    var imageName: String = ""
    
    init(position: CGPoint, weight: Int, imageName: String) {
        
        super.init(texture: SKTexture(imageNamed: imageName), color: UIColor.clearColor(), size: CGSizeMake(100, 100))
    
        self.weight = weight
        self.name = imageName
        self.position = position
        self.physicsBody = self.generatePhysicsBody()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func  generatePhysicsBody() -> SKPhysicsBody {
        
        let physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        
        physicsBody.categoryBitMask = PhysicsCategory.Food
        physicsBody.contactTestBitMask = PhysicsCategory.Player
        physicsBody.mass = 1
        physicsBody.affectedByGravity = true
        physicsBody.allowsRotation = false
        physicsBody.usesPreciseCollisionDetection = true
    
        return physicsBody
    }
    
    func removeFoodAfterPeriod (){
        let wait = SKAction.waitForDuration(4)
        self.runAction(wait) { 
            self.removeFromParent()
        }
    }
    
    func reduceFoodScale() {
        let scaleAction = SKAction.scaleTo(0.8, duration: 4)
        self.runAction(scaleAction)
    }
}
