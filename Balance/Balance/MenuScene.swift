//
//  MenuScene.swift
//  Balance
//
//  Created by Wesley Araujo on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var playButton: SKNode! = nil
    var backgroundLayer: BackgroundLayer!
    
    override func didMoveToView(view: SKView) {
        playButton = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 100, height: 40))
        
        playButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        self.addChild(playButton)
        
        let playLabel = SKLabelNode(fontNamed: "Chalkduster")
        playLabel.text = "Play!"
        playLabel.fontSize = 35
        playLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - playLabel.frame.size.height/2)
        playLabel.fontColor = UIColor.greenColor()
        
        self.addChild(playLabel)
        
        self.backgroundLayer = BackgroundLayer(size: size)
        self.addChild(self.backgroundLayer)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.locationInNode(self)
        
        if playButton.containsPoint(location) {

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
    }

}
