//
//  GameScene.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright (c) 2016 BEPiD. All rights reserved.
//

import SpriteKit
import CoreData

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameLayer: GameLayer! = nil
    var backgroundLayer: BackgroundLayer!
    
    var timer: NSTimer!
    var time:Int = 3
    var ascending = false
    var actionTimeGame = SKAction()
    let timerLabel = SKLabelNode(fontNamed:"Chalkduster")
    
    override init(size: CGSize) {
        super.init(size: size)
        self.physicsWorld.contactDelegate = self
        self.backgroundLayer = BackgroundLayer(size: size)
        self.addChild(self.backgroundLayer)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        timerLabel.fontSize = 65
        timerLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        let timer = SKAction.waitForDuration(1)
        self.actionTimeGame = SKAction.runBlock {
            if self.time <= 3 && self.ascending == false {
                if self.time == 0 {
                    self.timerLabel.text = "GO!"
                    
                    self.updateLabelPosition()
                    self.ascending = true
                    self.time += 1
                    
                    self.gameLayer = GameLayer(size: self.size)
                    self.addChild(self.gameLayer)
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
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.gameLayer.touchesMoved(touches, withEvent: event)
    }
    override func update(currentTime: CFTimeInterval) {

    }
    
    func didBeginContact(contact: SKPhysicsContact){
        self.gameLayer.didBeginContact(contact)
    }

    func updateLabelPosition() {
        self.runAction(SKAction.runBlock({
            self.timerLabel.position = CGPoint(x: self.timerLabel.position.x, y: CGRectGetMaxY(self.frame) - 160)
        }))
    }
    
    func saveHighscore() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("HighScore", inManagedObjectContext:managedContext)
        
        let highScore = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        highScore.setValue(self.time, forKey: "highscore")
        
        do {
            try managedContext.save()

        }catch{
            fatalError("failure to save highsore: \(error)")
        }
    }
    
    func getSavedHIghScore() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "HighScore")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            print(results)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
