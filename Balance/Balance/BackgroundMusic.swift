//
//  BackgroundMusic.swift
//  Balance
//
//  Created by Wesley Araujo on 5/12/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import AVFoundation

class BackgroundMusic: NSObject {
    
    var statusSoundEffect = true
    
    var music = AVAudioPlayer()
    static let sharedInstance = BackgroundMusic()
    
    func playMusic() {
        let musicUrl = NSBundle.mainBundle().URLForResource("bensound-funnysong", withExtension: "mp3")
        do {
            music = try AVAudioPlayer(contentsOfURL: musicUrl!)
            music.numberOfLoops = -1
            music.prepareToPlay()
//            music.volume = 0.0
            music.play()
        } catch {
            print("\(error)")
        }
    }
    
    func pauseMusic() {
        music.pause()
    }
    
    func removeEffects() -> Bool {
        
        return self.statusSoundEffect
    }

}
