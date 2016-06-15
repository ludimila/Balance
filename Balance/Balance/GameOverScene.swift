//
//  GameOverScene.swift
//  Balance
//
//  Created by Renan Leite on 08/06/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
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
        
        print(label.position)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
