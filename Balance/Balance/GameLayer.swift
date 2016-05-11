//
//  GameLayer.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class GameLayer: SKNode {
    
    var player: Player!
    
    init(size: CGSize) {
        super.init()
        
        self.player = Player(position: CGPointMake(size.width/2, size.height * 0.15))
    }

}
