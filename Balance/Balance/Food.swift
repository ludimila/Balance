//
//  Food.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class Food: GameObject {
    
    var weight: Int = 0
    var imageName: String = "Spaceship"
    
    
    init(weight: Int, imageName: String) {
        
        super.init(texture: SKTexture(imageNamed: imageName), color: UIColor.clearColor(), size: SKTexture(imageNamed: "sorvete").size())
    
        self.weight = weight
        self.position = self.generateRandomPosition()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func  generateRandomPosition() -> CGPoint {
        
        let randomWidth = Int(arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.size.width)))
        let maxHeight = UIScreen.mainScreen().bounds.size.height-(UIScreen.mainScreen().bounds.size.height/50)
        
        return CGPoint(x: randomWidth,y: Int(maxHeight))
    }
    

    
    
}//fim classe
