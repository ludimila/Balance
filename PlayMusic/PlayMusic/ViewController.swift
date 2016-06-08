//
//  ViewController.swift
//  PlayMusic
//
//  Created by Ludimila da Bela Cruz on 5/23/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: NSURL (fileURLWithPath: NSBundle.mainBundle().pathForResource("hp", ofType: "mp3")!), fileTypeHint:nil)
        } catch {
            print("erro")
        }
        
        
    }
    
    @IBAction func playSound(sender: AnyObject) {
        self.audioPlayer.play()
    }
    
}

