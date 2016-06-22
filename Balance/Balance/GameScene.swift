//
//  GameScene.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright (c) 2016 BEPiD. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameLayer: GameLayer! = nil
    var backgroundLayer: BackgroundLayer!
    var worldGravity = CGFloat(-1.0)
    
    var timer: NSTimer!
    var time:Int = 3
    var ascending = false
    var actionTimeGame = SKAction()
    let timerLabel = SKLabelNode(fontNamed:"CartoonistKooky")
    
    var actualSumFood = CGFloat()
    
    //HudLayer
    var hudLayer: HudLayer!
    
    override init(size: CGSize) {
        
        super.init(size: size)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        self.backgroundLayer = BackgroundLayer(size: size, scene: "game")
        self.addChild(self.backgroundLayer)
        
        
        //hudlayer
        self.hudLayer = HudLayer(size: size)
        self.addChild(hudLayer)
        
//        self.initialExplosion()
    }
    
    
    func initialExplosion() {
        let path = NSBundle.mainBundle().pathForResource("FireParticle", ofType: "sks")
        let fireParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        
        fireParticle.name = "fireParticle"
        fireParticle.position = CGPointMake(self.size.width/2, self.size.width/2.20)
        fireParticle.targetNode = self.scene
        
        self.addChild(fireParticle)
    }
    
    
    //timer label tem que ir pra hud e modularizar essa funcao

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.gravity = CGVectorMake(0.0, self.worldGravity)
        timerLabel.fontSize = 65
        timerLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        //smoke particle
        let path = NSBundle.mainBundle().pathForResource("SmokeParticle", ofType: "sks")
        let smokeParticleTaller = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        
        smokeParticleTaller.position = CGPointMake(self.size.width/2 + 50, self.size.width/2.15)
        smokeParticleTaller.name = "smokeParticleTaller"
        smokeParticleTaller.targetNode = self.scene
        self.addChild(smokeParticleTaller)
        
        let smokeParticleLowest = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        smokeParticleLowest.name = "smokeParticleLowest"
        smokeParticleLowest.position = CGPointMake(self.size.width/2-45, self.size.width/2.25)
        smokeParticleLowest.targetNode = self.scene
        self.addChild(smokeParticleLowest)
        
        
        
        let timer = SKAction.waitForDuration(1)
        self.actionTimeGame = SKAction.runBlock {
            if self.time <= 3 && self.ascending == false {
                if self.time == 0 {
                    self.updateLabelPosition()
                    self.ascending = true
                    self.time += 1
                    
                    self.gameLayer = GameLayer(size: self.size)
                    self.addChild(self.gameLayer)
                    self.gameLayer.hudLayer = self.hudLayer
                }else {
                    self.timerLabel.text = "\(self.time)"
                    self.time -= 1
                }
            }else {
                self.timerLabel.text = "\(self.time)"
                self.time += 1
            }
        }
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([actionTimeGame, timer])),withKey: "timer")

        self.addChild(timerLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        if let _ = self.gameLayer {
            self.gameLayer.pressesBegan(presses, withEvent: event)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if let _ = self.gameLayer {
            self.gameLayer.update(currentTime)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact){
        self.gameLayer.didBeginContact(contact)
    }

    func updateLabelPosition() {
        
        self.runAction(SKAction.runBlock({
            self.timerLabel.text = "GO!"
            self.timerLabel.position = CGPoint(x: (self.frame.width/2 + self.frame.width/3), y: CGRectGetMaxY(self.frame) - 160)
        }))
    }
}
