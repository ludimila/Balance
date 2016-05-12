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
    let size:CGSize
    
    init(size: CGSize) {
        
        self.size = size
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
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        print("")
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
                movementSpeed = (NSTimeInterval)((self.size.width - self.player.position.x) / 384)
                movement = SKAction.moveToX(size.width, duration: movementSpeed)
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
            self.player.position.x = self.size.width - 5
            
        } else if self.player.position.x >= self.size.width - 5 {
            self.player.position.x = CGFloat(50)
        }
    }
    
}
