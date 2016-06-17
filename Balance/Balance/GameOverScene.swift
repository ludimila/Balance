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
    
    var replayButton: SKSpriteNode! = nil
    var menuButton: SKSpriteNode! = nil
    
    var focusedNode: SKSpriteNode?
    
    let unfocusedScale: CGFloat = 0.7
    let focusScale: CGFloat = 1
    
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
        replayButton.name = "replayButton"
        replayButton.position = CGPoint(x: size.width/6, y: size.height/3)
        replayButton.zPosition = 3
        replayButton.xScale = unfocusedScale
        replayButton.yScale = unfocusedScale
        self.addChild(replayButton)
        
        
        
        
        menuButton = SKSpriteNode(texture: nil, color: SKColor.greenColor(), size: CGSizeMake(250, 75))
        menuButton.name = "menuButton"
        menuButton.position = CGPoint(x: size.width/3, y: size.height/3)
        menuButton.zPosition = 3
        menuButton.xScale = unfocusedScale
        menuButton.yScale = unfocusedScale
        self.addChild(menuButton)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        let touch: UITouch = touches.first!
//        let location: CGPoint = touch.locationInNode(self)
//        
//        if replayButton.containsPoint(location) {
//            
//            let scene = GameScene(size: self.size)
//            // Configure the view.
//            let skView = self.view
//            skView!.showsFPS = true
//            
//            skView!.showsNodeCount = true
//            
//            skView!.ignoresSiblingOrder = true
//            
//            scene.scaleMode = .AspectFill
//            
//            let transition = SKTransition.crossFadeWithDuration(1)
//            
//            skView!.presentScene(scene, transition: transition)
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            checkTouch (location)
        }
        
//        }
        
//        if menuButton.containsPoint(location) {
//            
//            let scene = MenuScene(size: self.size)
//            // Configure the view.
//            let skView = self.view
//            
//            scene.scaleMode = .AspectFill
//            
//            let transition = SKTransition.crossFadeWithDuration(1)
//            
//            skView!.presentScene(scene, transition: transition)
//            
//        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
//        let touch: UITouch = touches.first!
//        let location: CGPoint = touch.locationInNode(self)
//        
//        let sprite = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 50, height: 50))
//        sprite.position = location
//        sprite.zPosition = 1000
//        self.addChild(sprite)
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            checkTouch (location)
        }
    }
    
    func checkTouch(location: CGPoint) {
        
        self.enumerateChildNodesWithName("//*") {
         node, stop in
            
            if (node.name == "replayButton"){
                if let sprite: SKSpriteNode = node as? SKSpriteNode {
                    if (CGRectContainsPoint(sprite.frame, location)) {
                        sprite.xScale = self.focusScale
                        sprite.yScale = self.focusScale
                        
                        self.menuButton.xScale = self.unfocusedScale
                        self.menuButton.yScale = self.unfocusedScale
                        
                        sprite.zPosition = 100
                        sprite.name = self.replayButton.name
                        self.replayButton = sprite
                        
                        print(sprite.name)
                        
                    }
                }
            } else if (node.name == "menuButton") {
                if let sprite: SKSpriteNode = node as? SKSpriteNode {
                    if (CGRectContainsPoint(sprite.frame, location)) {
                        sprite.xScale = self.focusScale
                        sprite.yScale = self.focusScale
                        
                        self.replayButton.xScale = self.unfocusedScale
                        self.replayButton.yScale = self.unfocusedScale
                        
                        sprite.zPosition = 100
                        sprite.name = self.menuButton.name
                        self.menuButton = sprite
                        print(sprite.name)

                    }
            
                }
        
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
