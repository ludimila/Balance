//
//  GameOverMusic.swift
//  Balance
//
//  Created by Renan Leite on 22/06/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import AVFoundation


class GameOverMusic: NSObject {
    
    var music = AVAudioPlayer()
    static let sharedInstance = GameOverMusic()
    
    func playMusic() {
        let musicUrl = NSBundle.mainBundle().URLForResource("gameover", withExtension: "mp3")
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

}
