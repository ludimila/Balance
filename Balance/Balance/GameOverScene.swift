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
    
//    var replayButton: SKSpriteNode! = nil
//    var menuButton: SKSpriteNode! = nil
//    
//    //var focusedNode: SKSpriteNode?
    var focusableButtons = Array<CustomButton>()
    var focusIndex: Int!
//    
//    let unfocusedScale: CGFloat = 0.7
//    let focusScale: CGFloat = 1
    
    var swipeLeft: UISwipeGestureRecognizer!
    var swipeRight: UISwipeGestureRecognizer!
    
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
        
        
        
        //print(label.position)
        
    }
    
    override func didMoveToView(view: SKView){
        
        self.focusIndex = 0
        
        let menuButton = CustomButton(image: "Home.png", action: {
            let scene = MenuScene(fileNamed: "MenuScene")
            scene!.scaleMode = .AspectFill
            self.view!.presentScene(scene)
        })
        
        menuButton.position = CGPointMake(self.frame.size.width - 1200, self.frame.size.height - 700)
        self.addChild(menuButton)
        menuButton.isFocused = false
        
        self.focusableButtons.append(menuButton)
        self.setupGestureRecognizers(view)
        
        let restartButton = CustomButton(image: "Restart.png", action: {
            
            let scene = GameScene(size: self.size)
            let skView = self.view

            scene.scaleMode = .AspectFill
            let transition = SKTransition.crossFadeWithDuration(1)
            skView!.presentScene(scene, transition: transition)

        })
        
        restartButton.position = CGPointMake(self.frame.size.width - 750, self.frame.size.height - 700)
        self.addChild(restartButton)
        restartButton.isFocused = false
        
        self.focusableButtons.append(restartButton)
        self.setupGestureRecognizers(view)
        self.view?.userInteractionEnabled = true

        
    }
    
    func setupGestureRecognizers (view: SKView) -> Void {
        
        self.swipeLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(GameOverScene.handleSwipeLeft))
        self.swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(self.swipeLeft)
        
        self.swipeRight = UISwipeGestureRecognizer.init(target: self, action: #selector(GameOverScene.handleSwipeRight))
        self.swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(self.swipeRight)
        
        self.view?.userInteractionEnabled = true
        
    }
    
    func handleSwipeLeft (gesture: UISwipeGestureRecognizer) {
        
                if self.focusIndex > 0 {
                    self.focusIndex = self.focusIndex-1
        
                    let oldFocusedButton = self.focusableButtons[self.focusIndex+1]
                    oldFocusedButton.isFocused = false
        
                    let focusedButton = self.focusableButtons[self.focusIndex]
                    focusedButton.isFocused = true
        
                }
        
    }
    
    func handleSwipeRight (gesture: UISwipeGestureRecognizer) {
        
                if self.focusIndex < 1 {
                    self.focusIndex = self.focusIndex+1
        
                    let oldFocusedButton = self.focusableButtons[self.focusIndex-1]
                    oldFocusedButton.isFocused = false
        
                    let focusedButton = self.focusableButtons[self.focusIndex]
                    focusedButton.isFocused = true
        
                }
        
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        for button in self.focusableButtons {
            button.handlPress(presses, withEvent: event)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
