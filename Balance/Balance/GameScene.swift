//
//  GameScene.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright (c) 2016 BEPiD. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameLayer: GameLayer! = nil
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.physicsWorld.contactDelegate = self
        
        //Initializing the layers
        self.gameLayer = GameLayer(size: size)
        
        //Adding layers as child of GameScene
        self.addChild(self.gameLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func didMoveToView(view: SKView) {
//        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!"
//        myLabel.fontSize = 65
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
//        
//        self.addChild(myLabel)
//    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.gameLayer.touchesBegan(touches, withEvent: event)
//    }
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.gameLayer.touchesEnded(touches, withEvent: event)
//    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.gameLayer.touchesMoved(touches, withEvent: event)
    }
    override func update(currentTime: CFTimeInterval) {

    }
    
    
    func didBeginContact(contact: SKPhysicsContact){
        self.gameLayer.didBeginContact(contact)
        /* Called before each frame is rendered */
//        self.gameLayer.update(currentTime)
    }
}
