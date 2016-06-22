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
    var factory_name: SKLabelNode!
    
    init(size: CGSize, scene: String) {
        super.init()
        
        loadBackground(size, scene: scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadBackground(size: CGSize, scene: String) {
        
        if scene == "menu" {
            self.background = SKSpriteNode(texture: SKTexture(imageNamed: "initial_background"))
            self.background.position = CGPointMake(size.width/2, size.height/2)
            self.background.zPosition = -1
            self.background.setScale(1)
            self.background.texture!.filteringMode = .Nearest
            self.addChild(self.background)
            
            let factory = SKSpriteNode(texture: SKTexture(imageNamed: "factory"))
            factory.position = CGPointMake(1450, 400)
            factory.zPosition = 0
            factory.texture!.filteringMode = .Nearest
            self.addChild(factory)
            
            let title = SKSpriteNode(texture: SKTexture(imageNamed: "title"))
            title.position = CGPointMake(500, 750)
            title.zPosition = 0
            title.setScale(1.2)
            title.texture!.filteringMode = .Nearest
            self.addChild(title)
            
            self.factory_name = SKLabelNode(fontNamed:"CartoonistKooky")
            self.factory_name?.text = "FOOD FACTORY"
            self.factory_name.fontSize = 100
            self.factory_name?.position = CGPointMake(1480, 260)
            self.factory_name?.zPosition = 0.5
            self.factory_name?.alpha = 0.6
            self.addChild(self.factory_name)
            
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
