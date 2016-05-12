//
//  GameScene.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright (c) 2016 BEPiD. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameLayer: GameLayer!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        //Initializing the layers
        self.gameLayer = GameLayer(size: size)
        
        //Adding layers as child of GameScene
        self.addChild(self.gameLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.gameLayer.pressesBegan(presses, withEvent: event)
        print("Entrou no began")
    }
    
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.gameLayer.pressesEnded(presses, withEvent: event)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.gameLayer.update(currentTime)
    }
    
    
}
