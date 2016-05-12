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
        playButton = SKSpriteNode(texture: SKTexture(imageNamed: "play"), color: UIColor.clearColor(), size: CGSizeMake(300, 100))
        playButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.height/2)
        playButton.zPosition = 3
        self.addChild(playButton)
        
        
        self.backgroundLayer = BackgroundLayer(size: size)
        self.backgroundLayer.zPosition = -2
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
