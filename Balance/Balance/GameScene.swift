//
//  GameScene.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright (c) 2016 BEPiD. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var timer: NSTimer!
    var time:Int = 3
    var ascending = false
    var actionTimeGame = SKAction()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
    
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.fontSize = 65
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        let timer = SKAction.waitForDuration(1)
        self.actionTimeGame = SKAction.runBlock {
            if self.time <= 3 && self.ascending == false {
                if self.time == 0 {
                    myLabel.text = "GO!"
                    self.ascending = true
                    self.time += 1
                }else {
                    myLabel.text = "\(self.time)"
                    self.time -= 1
                }
            }else {
                myLabel.text = "\(self.time)"
                self.time += 1
            }
        }
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([actionTimeGame, timer])),withKey: "timer")
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func startGame() {
        print("Funcionou startGame")
    }
}
