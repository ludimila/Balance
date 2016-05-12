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
    
    var player: Player!
    
    init(size: CGSize) {
        super.init()
        
        self.player = Player(position: CGPointMake(size.width/2, size.height * 0.15))
        self.player.setScale(5.0)
        self.addChild(player)
        
        self.player.runAction(self.player.idle(), withKey: "animationAction")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //When touches began on screen the player move to the touch location
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            print(location)
//           
//        }
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
    
    
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        print("")
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
       
        }
    
    
    func began(presses: Set<UIPress>) {
        var movementSpeed: NSTimeInterval!
        var movement: SKAction!
        for press in presses {
            
            if press.type == .LeftArrow {
                movementSpeed = (NSTimeInterval)(self.player.position.x) / 270
                movement = SKAction.moveToX(0, duration: movementSpeed)
            } else if press.type == .RightArrow {
                movementSpeed = (NSTimeInterval)(-self.player.position.x) / 270
                movement = SKAction.moveToX(self.frame.size.width, duration: movementSpeed)
            }
            
            //            switch press.type {
            //            case .LeftArrow:
            //                movementSpeed = (NSTimeInterval)(self.player.position.x) / 270
            //                movement = SKAction.moveToX(0, duration: movementSpeed)
            //
            //            case .RightArrow:
            //                movementSpeed = (NSTimeInterval)(-self.player.position.x) / 270
            //                movement = SKAction.moveToX(self.frame.size.width, duration: movementSpeed)
            //            default:
            //                movementSpeed = nil
            //            }
            
            let actionBloc = SKAction.runBlock({
                self.player.runAction(self.player.idle(), withKey: "animationAction")
            })
            
            let sequence = SKAction.sequence([movement, actionBloc])
            
            self.player.runAction(self.player.running(), withKey: "animationAction")
            self.player.runAction(sequence, withKey: "moveAction")
        }
    }

}
