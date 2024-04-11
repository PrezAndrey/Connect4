//
//  SoundService.swift
//  Connect4
//
//  Created by Андрей  on 28.03.2024.
//
//
import SwiftUI
import AVKit


class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "sound", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
            
        }
    }
}
