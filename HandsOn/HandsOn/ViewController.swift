//
//  ViewController.swift
//  HandsOn
//
//  Created by Ludimila da Bela Cruz on 5/19/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import GameController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(controllerDidConnection), name: GCControllerDidConnectNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func searchController(sender: AnyObject) {
        
        print(GCController.controllers())
        self.setupExistingControllers()
    }

    
    func controllerDidConnection(notification: NSNotification){
    
    let controller = notification.object as! GCController
        
        print(controller.playerIndex)
    }
    
    func setupExistingControllers() {
        
        for controller in GCController.controllers(){
        
            controller.microGamepad?.buttonX.valueChangedHandler = {(button : GCControllerButtonInput, value : Float, pressed: Bool) in
                
                if value > 0{
                
                    print("apertou botao X")
                }
            
            }
            
            
            controller.microGamepad?.dpad.valueChangedHandler = {(direction: GCControllerDirectionPad, xValue: Float, yValue: Float) in
            
                print("X:\(xValue) Y:\(yValue)")
            }
        }
    }
    
    
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        
        for press in presses{
            
            switch press.type {
            case .Menu:
                print("menu")
            default:
                break
                
            }
            
        }
    }
}



