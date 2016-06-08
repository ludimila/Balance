//
//  GameViewController.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright (c) 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var skView : SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = MenuScene(fileNamed: "MenuScene") {
            self.skView = self.view as! SKView
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            skView.ignoresSiblingOrder = true
            
            scene.scaleMode = .AspectFill
            
            BackgroundMusic.sharedInstance.playMusic()
            
            skView.presentScene(scene)
        }
    }
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        super.pressesBegan(presses, withEvent: event)
        self.skView.scene?.pressesBegan(presses, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        print(#function)
        
    }
    
}
