//
//  GameLayer.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit

class GameLayer: SKNode {

    var foodSpawn = NSTimeInterval(1)
    var hudLayer:HudLayer?
    
    //player movement
    var presses = Set<UIPress>()
    var food: Food!
    var screenSize:CGSize!
    let foods = [(1, "chicken_leg"),
                 (1,"hamburguer"),
                 (1,"bacon"),
                 (-1,"apple"),
                 (-1,"lettuce"),
                 (-1, "corn")]
    
    var player: Player!

    
    init(size: CGSize) {
        
        self.screenSize = size
        super.init()
        
        self.hudLayer = HudLayer(size: self.frame.size)
        
        self.addPlayer()
        self.dropFood()

    }
    
    //adiciona Player
    func addPlayer(){
        self.player = Player(position: CGPointMake(self.screenSize.width/2, self.screenSize .height * 0.15))
        self.player.setScale(5.0)
        self.addChild(player)
        self.player.runAction(self.player.idle(), withKey: "animationAction")
    }
    
    //faz comida cair
    func dropFood() {
        
        let dropFood = SKAction.performSelector(#selector(putVariousFoodsInScreen), onTarget: self)
        let wait = SKAction.waitForDuration(self.foodSpawn, withRange: 2)
        let sequence = SKAction.sequence([dropFood, wait])
        let repeatActionForever = SKAction.repeatActionForever(sequence)
        
        self.runAction(repeatActionForever, withKey: "putFoodInScreen")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.presses = presses
        if self.player.isDead == false {
            self.movePlayer(self.presses)
        }
    }
    
    //move o player pra direita ou pra esquerda quando toca no controle
    func movePlayer(presses: Set<UIPress>){
        
        var movementSpeed: NSTimeInterval!
        var movement: SKAction!
        
        for press in presses {
            switch press.type {
            case .LeftArrow:
                movementSpeed = (NSTimeInterval)(self.player.position.x / self.player.speedInPixelsPerSecond)
                
                movement = SKAction.moveToX(0, duration: movementSpeed)
                self.player.xScale = -5

            case .RightArrow:
                movementSpeed = (NSTimeInterval)((self.screenSize.width - self.player.position.x)/self.player.speedInPixelsPerSecond)
                movement = SKAction.moveToX(self.screenSize.width, duration: movementSpeed)
                self.player.xScale = 5

            default:
                //stop movement
                movementSpeed = 0
                movement = SKAction.moveToX((self.player.position.x), duration: movementSpeed)
            }
            
            let actionBloc = SKAction.runBlock({
                self.player.runAction(self.player.idle(), withKey: "animationAction")
            })
            
            if movementSpeed != nil && movement != nil {
                let sequence = SKAction.sequence([movement, actionBloc])
                
                self.player.runAction(self.player.running(), withKey: "animationAction")
                self.player.runAction(sequence, withKey: "moveAction")
            }
        }
    }
    
    func update(currentTime: CFTimeInterval) {

        self.monitoringPlayerPosition()
        
        if self.food.position.y > self.screenSize.height {
            self.food.removeFromParent()
        }
    }
    
    //monitora onde o player tá, teletransporta e continua andandado
    func monitoringPlayerPosition() {
        
        if self.player.position.x <= CGFloat(0) {
            self.player.position.x = CGFloat(self.screenSize.width - 50)
            self.movePlayer(self.presses)
            
        } else if self.player.position.x >= self.screenSize.width - 5 {
            self.player.position.x = CGFloat(50)
            
            //chamar teletransporte andando
            self.movePlayer(self.presses)
        }
    }
    
    func putVariousFoodsInScreen() {
        let randomFood = Int(arc4random_uniform(6)+1)-1
        
        self.food = Food(position: self.generateRandomPosition(self.screenSize), weight: self.foods[randomFood].0, imageName: self.foods[randomFood].1)
        self.food.imageName = self.foods[randomFood].1
        self.food.setScale(2)
        self.addChild(self.food)
        self.food.reduceFoodScale()
        self.food.removeFoodAfterPeriod()
    }
    
    func  generateRandomPosition(size: CGSize) -> CGPoint {
        
        let randomWidth = Int(arc4random_uniform(UInt32(size.width)))
        
        let maxHeight = size.height
        
        return CGPointMake(CGFloat(randomWidth), maxHeight)
    }
    
    func didBeginContact(contact: SKPhysicsContact)  {
        if contact.bodyA.node!.isKindOfClass(Player) || contact.bodyB.node!.isKindOfClass(Food){
            let weight = (contact.bodyB.node as! Food).weight
            let nameFood = (contact.bodyB.node as! Food).imageName
            
            self.hudLayer?.movingBalance(nameFood, foodWeight: self.player.getWeight())
            
            self.soundEffects()
            //particulas ao comer
//             self.addEatParticle((contact.bodyB.node?.position)!)
    
            //atualiza peso do guaxinim
            self.player.changeWeight(weight)
            
            contact.bodyB.node?.removeFromParent()
            contact.bodyA.node?.runAction((contact.bodyA.node as! Player).eating(), completion: {
                (contact.bodyA.node as! Player).idle()
            })
        }
        if player.isDead == true {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(self.hudLayer?.timerLabel.text, forKey: "actualScore")
            
            
            self.removeAllFoods()
            self.deadPlayer()
        }
    }
    
    func soundEffects() {
        
        if BackgroundMusic.sharedInstance.statusSoundEffect == true{
            self.runAction(SKAction.playSoundFileNamed("eating2.mp3", waitForCompletion: true))
        }else{
            print("sem efeito sonoro")
        }
    }
    
    func deadPlayer(){
        self.player.speedInPixelsPerSecond = 0
        self.player.removeActionForKey("moveAction")
        
        if self.player.getWeight() > 0 {//comer demais
            self.player.runAction(self.player.exploding())
        }else {
            self.player.runAction(self.player.skeleton())
        }
        
        let gameoveraction = SKAction.waitForDuration(3)
        runAction(gameoveraction, completion: {
            self.saveHigshcore()
            self.gameOver()
        })
        
    }
    
    //salva o novo recorde e pega o novo pra por na label do gameover
    func saveHigshcore(){
        
        self.player.removeFromParent()
        let timer = Double((self.hudLayer?.timerLabel.text)!)
        let newHighScore = HighScore.saveHighscore(timer!)
        
    }
    
    func gameOver() {
        let transition = SKTransition.fadeWithColor(UIColor.clearColor(), duration: 3.0)
        let skview = self.scene?.view
        let newScene = GameOverScene(size: (self.scene?.size)!)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene?.removeAllActions()
        self.scene?.removeFromParent()
        skview?.presentScene(newScene, transition: transition)
        
        
    }
    
    func removeAllFoods() {
        //remove action of put food in screen
        self.removeActionForKey("putFoodInScreen")
        for i in self.foods {
            self.enumerateChildNodesWithName(i.1, usingBlock: { (food, stop) in
                food.removeFromParent()
            })
        }
    }
    
    func addEatParticle(position: CGPoint) {
        let path = NSBundle.mainBundle().pathForResource("FoodParticle", ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        particle.name = "foodParticle"
        particle.position = position
        particle.targetNode = self.scene
        self.addChild(particle)
    }
    
    
}
