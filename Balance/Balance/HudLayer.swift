//
//  HudLayer.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class HudLayer: SKNode {
    
    //balança
    var arrowBalance = SKSpriteNode()
    var balance = SKSpriteNode()
    var sum: CGFloat = 0
    
    let timerLabel = SKLabelNode(fontNamed:"CartoonistKooky")

    
    init(size: CGSize) {
        super.init()
        
        self.zPosition = 100
        
        //balance
        self.balance = SKSpriteNode.init(imageNamed: "balance")
        self.balance.position = CGPointMake(size.width/2+size.width/5, size.height/2+size.height/2.5)
        self.addChild(balance)
        
        
        //arrow
        self.arrowBalance = SKSpriteNode.init(imageNamed: "arrow")
        self.arrowBalance.anchorPoint = CGPointMake(0.5, 0.0)
        self.arrowBalance.position = CGPointMake(0, -100)
        self.arrowBalance.zPosition = 110
        self.balance.addChild(self.arrowBalance)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func movingBalance(foodName: String, foodWeight: Int){
        //transformar em constantes
        let rotateLeft = CGFloat(M_PI_4*(-0.5/10))
        let rotateRight = CGFloat(M_PI_4*(0.5/10))
                
        switch foodName {
        case "corn":
            self.sum += CGFloat(abs(foodWeight))/100
            self.arrowBalance.zRotation = rotateRight+(self.sum)
        case "lettuce":
            self.sum += CGFloat(abs(foodWeight))/100
            self.arrowBalance.zRotation = rotateRight+(self.sum)
        case "apple":
            self.sum += CGFloat(abs(foodWeight))/100
            self.arrowBalance.zRotation = rotateRight+(self.sum)
        case "hamburguer":
            self.sum -= CGFloat(abs(foodWeight))/100
            self.arrowBalance.zRotation = rotateLeft+(self.sum)
        case "bacon":
            self.sum -= CGFloat(abs(foodWeight))/100
            self.arrowBalance.zRotation = rotateLeft+(self.sum)
        case "chicken_leg":
            self.sum -= CGFloat(abs(foodWeight))/100
            self.arrowBalance.zRotation = rotateLeft+(self.sum)
        default:
            print(#function, "Error")
        }
        
    }


}
