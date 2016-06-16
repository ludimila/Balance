//
//  GameOverScene.swift
//  Balance
//
//  Created by Renan Leite on 08/06/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameOverScene: SKScene {
    
    var replayButton: SKNode! = nil
    var menuButton: SKNode! = nil
    
    override init(size: CGSize) {
     
        super.init(size: size)
        
        backgroundColor = SKColor.blackColor()
        
        //Write a message to player
//        let message = over ? "Game Over: Você comeu demais!!!" : "Game Over: Você comeu pouco!!!"
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Game Over!!!"
        label.fontSize = 100
        label.zPosition = 5
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(label)
        
//        runAction(SKAction.sequence([
//            SKAction.waitForDuration(1.0),
//            SKAction.runBlock(){
//                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
//                let scene = GameScene(size: size)
//                self.view?.presentScene(scene, transition: reveal)
//            }
//            ]))
        
        
        
        print(label.position)
        
    }
    
    override func didMoveToView(view: SKView){
        
        replayButton = SKSpriteNode(texture: nil, color: SKColor.orangeColor(), size: CGSizeMake(250, 75))
        replayButton.position = CGPoint(x: size.width/6, y: size.height/3)
        replayButton.zPosition = 3
        self.addChild(replayButton)
        
        
        menuButton = SKSpriteNode(texture: nil, color: SKColor.orangeColor(), size: CGSizeMake(250, 75))
        menuButton.position = CGPoint(x: size.width/3, y: size.height/3)
        menuButton.zPosition = 3
        self.addChild(menuButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.locationInNode(self)
        
        if replayButton.containsPoint(location) {
            
            let scene = GameScene(size: self.size)
            // Configure the view.
            let skView = self.view
            skView!.showsFPS = true
            
            skView!.showsNodeCount = true
            
            skView!.ignoresSiblingOrder = true
            
            scene.scaleMode = .AspectFill
            
            let transition = SKTransition.crossFadeWithDuration(1)
            
            skView!.presentScene(scene, transition: transition)
            
        }
        
        if menuButton.containsPoint(location) {
            
            let scene = MenuScene(size: self.size)
            // Configure the view.
            let skView = self.view
            
            scene.scaleMode = .AspectFill
            
            let transition = SKTransition.crossFadeWithDuration(1)
            
            skView!.presentScene(scene, transition: transition)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
