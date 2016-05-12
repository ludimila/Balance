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
        
        self.screenSize = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //When touches began on screen the player move to the touch location
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch = touches.first
//        let location = (touch?.locationInNode(self))! as CGPoint
//        var movementSpeed: NSTimeInterval!
//        
//        self.player.removeActionForKey("moveAction")
//        
//        //The movementSpeed Calc will be used to create a "constant" movement speed for any location.
//        if ((self.player.position.x - location.x) > 0) {
//            movementSpeed = (NSTimeInterval)(self.player.position.x - location.x) / 270
//            
//        } else {
//            
//            movementSpeed = (NSTimeInterval)(location.x - self.player.position.x) / 270
//        }
//        
//        let movement = SKAction.moveToX(location.x, duration: movementSpeed)
//        
//        let actionBloc = SKAction.runBlock { 
//            self.player.runAction(self.player.idle(), withKey: "animationAction")
//        }
//        
//        let sequence = SKAction.sequence([movement, actionBloc])
//        
//        self.player.runAction(self.player.running(), withKey: "animationAction")
//        
//        self.player.runAction(sequence, withKey: "moveAction")
//        
//    }
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch = touches.first
//        let location = (touch?.locationInNode(self))! as CGPoint
//        var movementSpeed: NSTimeInterval!
//        
//        self.player.removeActionForKey("moveAction")
//        
//        //The movementSpeed Calc will be used to create a "constant" movement speed for any location.
//        if ((self.player.position.x - location.x) > 0) {
//            movementSpeed = (NSTimeInterval)(self.player.position.x - location.x) / 270
//            
//        } else {
//            
//            movementSpeed = (NSTimeInterval)(location.x - self.player.position.x) / 270
//        }
//        
//        let movement = SKAction.moveToX(location.x, duration: movementSpeed)
//        
//        let actionBloc = SKAction.runBlock {
//            self.player.runAction(self.player.idle(), withKey: "animationAction")
//        }
//        
//        let sequence = SKAction.sequence([movement, actionBloc])
//        
//        self.player.runAction(self.player.running(), withKey: "animationAction")
//        
//        self.player.runAction(sequence, withKey: "moveAction")
//    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = (touch?.locationInNode(self))! as CGPoint
        var movementSpeed: NSTimeInterval!
        
        self.player.removeActionForKey("moveAction")
        
        //The movementSpeed Calc will be used to create a "constant" movement speed for any location.
        if ((self.player.position.x - location.x) > 0) {
            movementSpeed = (NSTimeInterval)(self.player.position.x - location.x) / 270
            
        } else {
            
            movementSpeed = (NSTimeInterval)(location.x - self.player.position.x) / 270
        }
        
        let movement = SKAction.moveToX(location.x, duration: movementSpeed)
        
        let actionBloc = SKAction.runBlock {
            self.player.runAction(self.player.idle(), withKey: "animationAction")
        }
        
        let sequence = SKAction.sequence([movement, actionBloc])
        
        self.player.runAction(self.player.running(), withKey: "animationAction")
        
        self.player.runAction(sequence, withKey: "moveAction")
    }
    
    func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if player.position.x < -10 {
            let moveRightWall = SKAction.moveToX(self.frame.width - 90, duration: 0)
            self.player.runAction(moveRightWall)
            
        }
        else if (self.player.position.x > self.frame.width + 10) {
            let moveLeftWall = SKAction.moveToX(90, duration: 0)
            self.player.runAction(moveLeftWall)
            
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
    
    
}//fim classe
