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
    var focusableButtons = Array<CustomButton>()
    var focusIndex: Int!
    
    var swipeLeft: UISwipeGestureRecognizer!
    var swipeRight: UISwipeGestureRecognizer!
    
    var backgroundLayer: BackgroundLayer!
    
    override init(size: CGSize) {
     
        super.init(size: size)
        
        self.backgroundLayer = BackgroundLayer(size: size, scene: "game_over")
        self.addChild(self.backgroundLayer)
    }
    
    override func didMoveToView(view: SKView){
        self.focusIndex = 0
        
        let savedHighScore = HighScore.getSavedHighScore()
        
        let label = SKLabelNode(fontNamed: "CartoonistKooky")
        label.text = "GAME OVER"
        label.fontSize = 100
        label.zPosition = 5
        label.fontColor = SKColor.init(red: 251/255, green: 57/255, blue: 66/255, alpha: 1)
        label.position = CGPoint(x: size.width/2, y: size.height/1.5 + 200)
        self.addChild(label)
        
        let shadowLabel = SKLabelNode(fontNamed: "CartoonistKooky")
        shadowLabel.text = "GAME OVER"
        shadowLabel.fontSize = 100.5
        shadowLabel.zPosition = 4
        shadowLabel.fontColor = SKColor.whiteColor()
        shadowLabel.position = CGPoint(x: size.width/2, y: size.height/1.5 + 200)
        self.addChild(shadowLabel)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let actualScore = defaults.objectForKey("actualScore")
        
        
        let score = SKLabelNode(fontNamed: "CartoonistKooky")
        score.text = "SCORE:  \(String(actualScore!))"
        score.fontSize = 100
        score.zPosition = 5
        score.fontColor = SKColor.init(red: 251/255, green: 57/255, blue: 66/255, alpha: 1)
        score.position = CGPoint(x: size.width/2, y: size.height/1.5)
        self.addChild(score)
        
        
        let scoreShadow = SKLabelNode(fontNamed: "CartoonistKooky")
        scoreShadow.text = "SCORE:  \(String(actualScore!))"
        scoreShadow.fontSize = 100.5
        scoreShadow.zPosition = 4
        scoreShadow.fontColor = SKColor.whiteColor()
        scoreShadow.position = CGPoint(x: size.width/2, y: size.height/1.5)
        self.addChild(scoreShadow)

        
        
        let highscore = SKLabelNode(fontNamed: "CartoonistKooky")
        highscore.text = ("HIGHSCORE: \(String(savedHighScore))")
        highscore.fontSize = 100
        highscore.zPosition = 5
        highscore.fontColor = SKColor.init(red: 251/255, green: 57/255, blue: 66/255, alpha: 1)
        highscore.position = CGPoint(x: label.position.x, y: size.height/1.5 - 200)
        self.addChild(highscore)
        
        let highscoreShadow = SKLabelNode(fontNamed: "CartoonistKooky")
        highscoreShadow.text = ("HIGHSCORE: \(String(savedHighScore))")
        highscoreShadow.fontSize = 100.5
        highscoreShadow.zPosition = 4
        highscoreShadow.fontColor = SKColor.whiteColor()
        highscoreShadow.position = CGPoint(x: label.position.x, y: size.height/1.5 - 200)
        self.addChild(highscoreShadow)
        
        let restartButton = CustomButton(image: "play_again", action: {
            
            let scene = GameScene(size: self.size)
            let skView = self.view
            
            scene.scaleMode = .AspectFill
            let transition = SKTransition.crossFadeWithDuration(1)
            skView!.presentScene(scene, transition: transition)
            
        })
        
        restartButton.position = CGPointMake(self.frame.size.width - 1200, self.frame.size.height - 700)
        self.addChild(restartButton)
        restartButton.isFocused = false
        
        self.focusableButtons.append(restartButton)
        self.setupGestureRecognizers(view)
        self.view?.userInteractionEnabled = true
        
        
        let menuButton = CustomButton(image: "home", action: {
            let scene = MenuScene(fileNamed: "MenuScene")
            scene!.scaleMode = .AspectFill
            self.view!.presentScene(scene)
        })
        
        menuButton.position = CGPointMake(self.frame.size.width - 750, self.frame.size.height - 700)
        self.addChild(menuButton)
        menuButton.isFocused = false
        
        self.focusableButtons.append(menuButton)
        self.setupGestureRecognizers(view)
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
