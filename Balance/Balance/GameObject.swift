//
//  GameObject.swift
//  Balance
//
//  Created by Ludimila da Bela Cruz on 5/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

class GameObject: SKSpriteNode {
    
    struct PhysicsCategory {
        static let Player: UInt32 = 1
        static let Food: UInt32 = 2
    }
    
    func generatePhysicsBody() -> SKPhysicsBody {
        
        //Override
        return SKPhysicsBody(rectangleOfSize: CGSizeMake(100, 100))
    }
    
    func setBasicAttributes() {
        
        //Override
    }
    
    func beginContactWithNode(node: SKNode, withBitmask bitmask: UInt32, andContact contact: SKPhysicsContact) {
        
        //Override
    }
    
    func endContactWithNode(node: SKNode, withBitmask bitmask: UInt32, andContact contact: SKPhysicsContact) {
        
        //Override
    }

}
