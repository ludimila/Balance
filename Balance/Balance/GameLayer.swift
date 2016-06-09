//
//  GameLayer.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class GameLayer: SKNode {
    
    
    //player movement
    var presses = Set<UIPress>()
    
    var food: Food!
    var screenSize:CGSize!
    let foods = [(1,"hamburguer"),
                 (3,"bacon"),
                 (-1,"apple"),
                 (-3,"lettuce")]
    var player: Player!
    
    init(size: CGSize) {
        self.screenSize = size
        super.init()
        self.player = Player(position: CGPointMake(size.width/2, size.height * 0.15))
        self.player.setScale(5.0)
        self.addChild(player)
        
        self.player.runAction(self.player.idle(), withKey: "animationAction")
        
        
        let dropFood = SKAction.performSelector(#selector(putVariousFoodsInScren), onTarget: self)
        let wait = SKAction.waitForDuration(0.4, withRange: 2)
        let sequence = SKAction.sequence([dropFood, wait])
        let repeatActionForever = SKAction.repeatActionForever(sequence)
        
        self.runAction(repeatActionForever)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.presses = presses
        self.movePlayer(self.presses)
    }
    
    //move o player pra direita ou pra esquerda quando toca no controle
    func movePlayer(presses: Set<UIPress>){

        var movementSpeed: NSTimeInterval!
        var movement: SKAction!
        for press in presses {
            switch press.type {
            case .LeftArrow:
                movementSpeed = (NSTimeInterval)(self.player.position.x / 384)
                movement = SKAction.moveToX(0, duration: movementSpeed)
                
            case .RightArrow:
                movementSpeed = (NSTimeInterval)((self.screenSize.width - self.player.position.x) / 384)
                movement = SKAction.moveToX(self.screenSize.width, duration: movementSpeed)
            default:
                movementSpeed = nil
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
    
    
    
    func putVariousFoodsInScren() {
        
        let randomFood = Int(arc4random_uniform(4)+1)-1
        
        self.food = Food(position: self.generateRandomPosition(self.screenSize), weight: self.foods[randomFood].0, imageName: self.foods[randomFood].1)
        self.food.setScale(0.8)
        self.addChild(self.food)
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
            
            let weightPlayer = Int()
//            weight = player.getWeight()
            
            if weightPlayer < 1 || weightPlayer > 10 {
                //gameover
                //stop em todas as animations (skactions)
                self.removeAllActions()
                //remover todas as sprites
                self.removeAllChildren()
                //salvar a pontuacao no banco (if best score)
                
                //se continuar a instancia voltar elas pro estado inicial(zerar o peso do guaxinim, zerar o tempo da musica, zerar a pontuacao, zerar o tempo)
                
                //run na tela de game over
                let loseAction = SKAction.runBlock(){
                    let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                    let gameOverScene = GameOverScene(size: self.screenSize, over: false)
                    self.view?.presentScene(gameOverScene, transition: reveal)
                }
            }else {
                self.player.changeWeight(weight,name: nameFood)
                contact.bodyB.node?.removeFromParent()
                contact.bodyA.node?.runAction((contact.bodyA.node as! Player).eating(), completion: {
                    (contact.bodyA.node as! Player).idle()
                })
            }
        }
    }
    
    
}
