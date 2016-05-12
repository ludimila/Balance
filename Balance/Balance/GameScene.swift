//
//  GameScene.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright (c) 2016 BEPiD. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameLayer: GameLayer! = nil
    
    
    
    override func didMoveToView(view: SKView) {
        
        self.gameLayer = GameLayer(size: UIScreen.mainScreen().bounds.size)
        self.addChild(self.gameLayer)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
