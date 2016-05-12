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
    
    
    var food: Food!
    var screenSize:CGSize!
    let foods = [(1,"batata"),
                 (2,"sorvete"),
                 (3,"algodao"),
                 (-1,"batata"),
                 (-2,"algodao"),
                 (-3,"Spaceship")]

    
    init(size: CGSize) {
        super.init()
        
        
        let action = SKAction.repeatActionForever(putVariousFoodsInScren())
            
            
        self.runAction(action)
        self.screenSize = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func putVariousFoodsInScren() -> SKAction {
        
        let customAction = SKAction.customActionWithDuration(1) {_,_ in 
            
            let randomFood = Int(arc4random_uniform(5) + 1)
            
            self.food = Food(position: self.generateRandomPosition(self.screenSize), weight: self.foods[randomFood].0, imageName: self.foods[randomFood].1)
            self.addChild(self.food)
            
        }
        
        return customAction
        
    }
    
    
    func  generateRandomPosition(size: CGSize) -> CGPoint {
        
        let randomWidth = Int(arc4random_uniform(UInt32(size.width)))
        
        let maxHeight = size.height
                
        return CGPointMake(CGFloat(randomWidth), maxHeight)
    }
    
    
    
}//fim classe
