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

    init(size: CGSize) {
        super.init()
        
        let action = SKAction.repeatActionForever(putVariousFoodsInScren())
        self.runAction(action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func putVariousFoodsInScren() -> SKAction {
        
        let foods = [(1,"batata"),
                     (2,"sorvete"),
                     (3,"algodao"),
                     (-1,"batata"),
                     (-2,"algodao"),
                     (-3,"Spaceship")]

        let randomFood = Int(arc4random_uniform(UInt32(foods.count)))
        
        
        let customAction = SKAction.customActionWithDuration(1) {_,_ in 
            
            self.food = Food(weight: foods[randomFood].0, imageName: foods[randomFood].1)
            self.setScale(0.2)
            self.addChild(self.food)
            
        }
        
        return customAction
        
    }
    
    
}//fim classe
