//
//  CustomButton.swift
//  Balance
//
//  Created by Renan Leite on 17/06/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class CustomButton: SKSpriteNode {

    typealias ActionBlock = () -> ()

    
    var actionBlock: ActionBlock!
    var enabled: Bool!
    var scaleInternal: CGFloat!
    var originalScale: CGFloat!
    var originalRotationAngle: CGFloat!
    var isFocused: Bool! = false {
        didSet{
            if isFocused == false {
                stopFocusMode()
            } else {
                startFocusMode()
            }
        }
    }
    
    init(image: String, action: ActionBlock) {
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.actionBlock = action
        self.enabled = true
        self.setScale(1)
        self.originalScale = 1
        //self.originalRotationAngle = self.zRotation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self.parent!)
            if (self.containsPoint(location)) {
                if (self.enabled!) {
                    self.scaleTo(self.scaleInternal+0.25, withDuration: 0.05, withDelay: 0)
                }
                if (self.actionBlock != nil) {
                    self.actionBlock()
                }
            }
        }
    }
    
    override func setScale(scale: CGFloat) -> Void {
        super.setScale(scale)
        self.scaleInternal = scale
    }
    
    func scaleTo(scale: CGFloat, withDuration duration: NSTimeInterval, withDelay delay: NSTimeInterval) {
        
        let delayAction = SKAction.waitForDuration(delay)
        let scaleTo = SKAction.scaleTo(scale, duration: duration)
        let sequence = SKAction.sequence([delayAction, scaleTo])
        
        self.runAction(sequence) {
            self.scaleTo(scale, withDuration: duration, withDelay: delay)
        }
    }
    
    internal func startFocusMode () -> Void {
        
        let enterFocusMode = SKAction.scaleTo(1.2, duration: 0.5)
        let scaleDown = SKAction.scaleTo(0.8, duration: 0.5)
        let scaleSequence = SKAction.sequence([enterFocusMode, scaleDown])
        self.runAction(SKAction.repeatActionForever(scaleSequence), withKey: "focusMode")
        
    }
    
    internal func stopFocusMode () -> Void {
        
        self.removeActionForKey("focusMode")
        self.removeAllActions()
        self.resetButton()
        
    }
    
    func resetButton () -> Void {
        
        //let resetRotation = SKAction.rotateToAngle(self.originalRotationAngle, duration: 0.25)
        let resetScale = SKAction.scaleTo(1, duration: 0.25)
        let group = SKAction.group([resetScale])
        self.runAction(group)
        
    }
    
    func handlPress(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        
        if self.isFocused == true {
            for press in presses {
                switch press.type {
                case UIPressType.PlayPause, UIPressType.Select:
                    self.actionBlock()
                default:
                    print("teste")
                }
            }
        }
        
    }
    
}
