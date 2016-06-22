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
    var arrCustomButton = Array<CustomButton>()
    
    var musicBG: BackgroundMusic! = nil
    
    var focusIndex = Int()
    
    var swipeUp: UISwipeGestureRecognizer!
    var swipeLeft: UISwipeGestureRecognizer!
    var swipeRight: UISwipeGestureRecognizer!
    
    var soundButton: CustomButton!
    
    
    override func didMoveToView(view: SKView) {
        
        self.musicBG = BackgroundMusic.sharedInstance
        musicBG.playMusic()
        
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
        let gamecenterButton = CustomButton(image: "gamecenter", action: {
            self.gameCenterAction()
        })
        gamecenterButton.zPosition = 0
        gamecenterButton.position = CGPointMake(250, 180)
        gamecenterButton.setScale(1.2)
        self.addChild(gamecenterButton)
        gamecenterButton.isFocused = false
        self.arrCustomButton.append(gamecenterButton)
        
        let playButton = CustomButton(image: "play", action: {
            self.playButtonAction()
        })
        playButton.zPosition = 0
        playButton.position = CGPointMake(430, 400)
        self.addChild(playButton)
        playButton.isFocused = false
        self.arrCustomButton.append(playButton)
        self.setupGestureRecognizers(view!)

        var button_name = String()
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var isPlaying:Bool = true
        isPlaying = defaults.boolForKey("isPlaying")
        if isPlaying {
            button_name = "sound_on"
        }else {
            button_name = "sound_off"
        }
        
       
        self.soundButton = CustomButton(image: button_name, action: {
            self.soundButtonAction()
        })
        self.soundButton.position = CGPointMake(550, 160)
        self.soundButton.zPosition = 0
        self.soundButton.setScale(1.2)
        self.addChild(self.soundButton)
        self.soundButton.isFocused = false
        self.arrCustomButton.append(soundButton)
    }
    
    //MARK: - Button's Action
    func playButtonAction() {
        let scene = GameScene(size: self.size)
        let skView = self.view
        
        scene.scaleMode = .AspectFill
        let transition = SKTransition.crossFadeWithDuration(1)
        skView!.presentScene(scene, transition: transition)
    }
    
    func soundButtonAction() {
        self.musicBG = BackgroundMusic.sharedInstance
        let defaults = NSUserDefaults.standardUserDefaults()
        if self.musicBG.music.playing == true {
            self.musicBG.music.pause()
            //change sprite image
            self.soundButton.texture = SKTexture(imageNamed: "sound_off")
            defaults.setBool(false, forKey: "isPlaying")
        }else {
            self.musicBG.music.play()
            //change sprite image
            self.soundButton.texture = SKTexture(imageNamed: "sound_on")
            defaults.setBool(true, forKey: "isPlaying")
        }
    }
    
    func gameCenterAction() {
        //TO DO
        print("Clicou game center")
    }
    
    //MARK: - Gesture Recognizer
    func setupGestureRecognizers(view: SKView) {
        self.swipeLeft = UISwipeGestureRecognizer.init(target:self, action: #selector(MenuScene.handleSwipeLeft))
        self.swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(self.swipeLeft)
        
        self.swipeUp = UISwipeGestureRecognizer.init(target:self, action: #selector(MenuScene.handleSwipeUp))
        self.swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(self.swipeUp)
        
        
        self.swipeRight = UISwipeGestureRecognizer.init(target:self, action: #selector(MenuScene.handleSwipeRight))
        self.swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(self.swipeRight)
    
        self.userInteractionEnabled = true
    }
    
    func handleSwipeLeft(gesture: UIGestureRecognizer) {
        self.removeFocus(self.focusIndex)
        self.focusIndex = 0
        
        self.addFocus(self.focusIndex)
    }
    
    func handleSwipeUp(gesture: UIGestureRecognizer) {
        self.removeFocus(self.focusIndex)
        self.focusIndex = 1
        
        self.addFocus(self.focusIndex)
    }
    
    func handleSwipeRight(gesture: UIGestureRecognizer) {
        self.removeFocus(self.focusIndex)
        self.focusIndex = 2
        
        self.addFocus(self.focusIndex)
    }
    
    //MARK: - Focus
    func addFocus(index: Int) {
        let button = self.arrCustomButton[index]
        button.isFocused = true
    }
    
    func removeFocus(index: Int) {
        self.arrCustomButton[index].isFocused = false
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        for button in self.arrCustomButton {
            button.handlPress(presses, withEvent: event)
        }
    }
}
