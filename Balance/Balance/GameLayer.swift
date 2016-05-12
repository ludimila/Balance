//
//  GameLayer.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class GameLayer: SKNode {
    
    var food: Food!
    var screenSize:CGSize!
    let foods = [(1,"batata"),
                 (2,"sorvete"),
                 (3,"algodao"),
                 (-1,"batata"),
                 (-2,"algodao"),
                 (-3,"Spaceship")]
    var player: Player!
    
    init(size: CGSize) {
        self.screenSize = size
        super.init()
        
        self.player = Player(position: CGPointMake(size.width/2, size.height * 0.15))
        self.player.setScale(5.0)
        self.addChild(player)
        
        self.player.runAction(self.player.idle(), withKey: "animationAction")
        
        
        let dropFood = SKAction.performSelector(#selector(putVariousFoodsInScren), onTarget: self)
        let wait = SKAction.waitForDuration(0.5, withRange: 0.1)
        let sequence = SKAction.sequence([dropFood, wait])
        let repeatActionForever = SKAction.repeatActionForever(sequence)
        
        self.runAction(repeatActionForever)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        
        var movementSpeed: NSTimeInterval!
        var movement: SKAction!
        for press in presses {
            switch press.type {
            case .LeftArrow:
                movementSpeed = (NSTimeInterval)(self.player.position.x / 384)
                movement = SKAction.moveToX(0, duration: movementSpeed)
                print("left")
                
            case .RightArrow:
                print("right")
                movementSpeed = (NSTimeInterval)((self.screenSize.width - self.player.position.x) / 384)
                movement = SKAction.moveToX(self.screenSize.width, duration: movementSpeed)
            default:
                movementSpeed = nil
            }
            
            let actionBloc = SKAction.runBlock({
                self.player.runAction(self.player.idle(), withKey: "animationAction")
            })
            
            if movementSpeed != nil && movement != nil {
                let sequence = SKAction.sequence([movement, actionBloc])
                
                self.player.runAction(self.player.running(), withKey: "animationAction")
                self.player.runAction(sequence, withKey: "moveAction")
            }
        }
    }
    
    
    func update(currentTime: CFTimeInterval) {
        if self.player.position.x <= 0 {
           self.player.position.x = self.screenSize.width - 5
        } else if self.player.position.x >= self.screenSize.width - 5 {
            self.player.position.x = CGFloat(50)
        }
    }
    
    func putVariousFoodsInScren() {
        
        let randomFood = Int(arc4random_uniform(5) + 1)
        
        self.food = Food(position: self.generateRandomPosition(self.screenSize), weight: self.foods[randomFood].0, imageName: self.foods[randomFood].1)
        
        self.addChild(self.food)
    }
    
    func  generateRandomPosition(size: CGSize) -> CGPoint {
        
        let randomWidth = Int(arc4random_uniform(UInt32(size.width)))
        
        let maxHeight = size.height
                
        return CGPointMake(CGFloat(randomWidth), maxHeight)
    }
    
    func didBeginContact(contact: SKPhysicsContact)  {
        
        if contact.bodyA.node!.isKindOfClass(Player) || contact.bodyB.node!.isKindOfClass(Food){
        
            contact.bodyB.node?.removeFromParent()
        }
    }
    
}
