//
//  MenuScene.swift
//  Balance
//
//  Created by Wesley Araujo on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var backgroundLayer: BackgroundLayer!
    
    override func didMoveToView(view: SKView) {
        //smoke particle
        let path = NSBundle.mainBundle().pathForResource("SmokeParticle", ofType: "sks")
        let smokeParticleTaller = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        
        smokeParticleTaller.position = CGPointMake(1350, 720)
        smokeParticleTaller.name = "smokeParticleTaller"
        smokeParticleTaller.targetNode = self.scene
        smokeParticleTaller.particlePositionRange = CGVectorMake(60, 40)
        self.addChild(smokeParticleTaller)
        
        let smokeParticleLowest = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        smokeParticleLowest.name = "smokeParticleLowest"
        smokeParticleLowest.position = CGPointMake(1565, 820)
        smokeParticleLowest.targetNode = self.scene
        smokeParticleLowest.particlePositionRange = CGVectorMake(60, 40)
        self.addChild(smokeParticleLowest)
        
        
        //Add BackgronudLayer
        self.backgroundLayer = BackgroundLayer(size: size, scene: "menu")
        self.backgroundLayer.zPosition = -2
        self.addChild(self.backgroundLayer)
        
        self.addButtons()
    }
    
    
    func addButtons() {
        let playButton = CustomButton(image: "play", action: {
            print("playButton")
        })
        playButton.zPosition = 0
        playButton.position = CGPointMake(430, 400)
        self.addChild(playButton)
        
        let gamecenterButton = CustomButton(image: "gamecenter", action: {
            print("clicou game center")
        })
        gamecenterButton.zPosition = 0
        gamecenterButton.position = CGPointMake(250, 180)
        gamecenterButton.setScale(1.2)
        self.addChild(gamecenterButton)
        
        let soundButton = CustomButton(image: "sound_on", action: {
            print("clicou sound")
        })
        soundButton.position = CGPointMake(550, 160)
        soundButton.zPosition = 0
        soundButton.setScale(1.2)
        self.addChild(soundButton)

    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
//        if playButton.containsPoint(location) {
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
//        }
//    }

}
