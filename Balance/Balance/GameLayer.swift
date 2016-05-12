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
        
//        let foods = [(1,"Spaceship"),
//                     (2,"Spaceship"),
//                     (3,"Spaceship"),
//                     (-1,"Spaceship"),
//                     (-2,"Spaceship"),
//                     (-3,"Spaceship")]
        
        self.food = Food(position: CGPointMake(size.width/2, size.height/2), weight: -2, imageName: "Spaceship")
        self.food.setScale(2.0)
        self.addChild(self.food)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first        
        
        
    }

    
    
}
