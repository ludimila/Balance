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
    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.gameLayer.touchesMoved(touches, withEvent: event)
//    }
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.gameLayer.touchesBegan(touches, withEvent: event)
//    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.gameLayer.began(presses)
        print("Entrou no began")
    }
    
    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.gameLayer.pressesEnded(presses, withEvent: event)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
}
