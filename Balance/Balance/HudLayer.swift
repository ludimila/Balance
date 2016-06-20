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
    
    init(size: CGSize) {
        super.init()
        
        //balance
        self.balance = SKSpriteNode.init(imageNamed: "balance")
        self.balance.position = CGPointMake(size.width/2, size.height - balance.frame.size.height)
        self.addChild(balance)
        
        
        //arrow
        self.arrowBalance = SKSpriteNode.init(imageNamed: "arrow")
        self.arrowBalance.anchorPoint = CGPointMake(0.5, 0.0)
        self.balance.addChild(self.arrowBalance)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func movingBalance(soma: CGFloat, foodName: String, foodWeight: Int) -> CGFloat{
        //transformar em constantes
        let rotateLeft = CGFloat(M_PI_4*(-0.5/10))
        let rotateRight = CGFloat(M_PI_4*(0.5/10))
        
        var total = soma
        
        switch foodName {
        case "corn":
            total += CGFloat(foodWeight)/100
            self.arrowBalance.zRotation = rotateRight+(total)
        case "lettuce":
            total += CGFloat(foodWeight)/100
            self.arrowBalance.zRotation = rotateRight+(total)
        case "apple":
            total += CGFloat(foodWeight)/100
            self.arrowBalance.zRotation = rotateRight+(total)
        case "hamburguer":
            total -= CGFloat(foodWeight)/100
            self.arrowBalance.zRotation = rotateLeft+(total)
        case "bacon":
            total -= CGFloat(foodWeight)/100
            self.arrowBalance.zRotation = rotateLeft+(total)
        case "chicken_leg":
            total -= CGFloat(foodWeight)/100
            self.arrowBalance.zRotation = rotateLeft+(total)
        default:
            print(#function, "Error")
        }
        
        return total
    }


}
