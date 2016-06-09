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
    
    init(size: CGSize, over: Bool) {
     
        super.init(size: size)
        
        backgroundColor = SKColor.blackColor()
        
        //Write a message to player
        let message = over ? "Game Over: Você comeu demais!!!" : "Game Over: Você comeu pouco!!!"
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        runAction(SKAction.sequence([
            SKAction.waitForDuration(3.0),
            SKAction.runBlock(){
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition: reveal)
            }
            ]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
