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
    
    init(position: CGPoint, weight: Int, imageName: String) {
        
        super.init(texture: SKTexture(imageNamed: imageName), color: UIColor.clearColor(), size: SKTexture(imageNamed: "sorvete").size())
    
        self.weight = weight
        self.position = position
        self.setScale(2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

    
    
}//fim classe
