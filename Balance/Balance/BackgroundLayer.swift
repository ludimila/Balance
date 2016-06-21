//
//  BackgroundLayer.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class BackgroundLayer: SKNode {
    
    var background: SKSpriteNode!
    
    init(size: CGSize, scene: String) {
        super.init()
        
        loadBackground(size, scene: scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadBackground(size: CGSize, scene: String) {
        
        if scene == "menu" {
            
        }else if scene == "game" {
            self.background = SKSpriteNode(texture: SKTexture(imageNamed: "background"))
            self.background.position = CGPointMake(size.width/2, size.height/2)
            self.background.zPosition = -1
            self.background.setScale(1)
            self.background.texture!.filteringMode = .Nearest
            self.addChild(self.background)
        }

    }
}
