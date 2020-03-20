//
//  AudioPlayer.swift
//  MusicPlayer
//
//  Created by Saigaurav Purushothaman on 3/20/20.
//  Copyright © 2020 saipurush. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayer: NSObject, AVAudioPlayerDelegate, ObservableObject {
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    var audioPlayer: AVAudioPlayer!
    var songNum: Int = 0
    var songs: [String]!
    var isPlaying: Bool = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func initPlayback() {
        let song = songs[songNum]
        let sound = Bundle.main.path(forResource: song.fileName(), ofType: song.fileExtension())
        let playbackSession = AVAudioSession.sharedInstance()
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        try! playbackSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [AVAudioSession.CategoryOptions.mixWithOthers])
        audioPlayer.delegate = self
    }
    
    func startPlayback() {
        audioPlayer.play()
        isPlaying = true
    }
    
    func pausePlayback() {
        audioPlayer.pause()
        isPlaying = false
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func playPauseTrack() {
        if isPlaying {
            pausePlayback()
        } else {
            startPlayback()
        }
    }
    
    func previousTrack() {
        songNum = (songs.count + songNum - 1) % songs.count
        stopPlayback()
        initPlayback()
        startPlayback()
    }
    
    func nextTrack() {
        songNum = (songNum + 1) % songs.count
        stopPlayback()
        initPlayback()
        startPlayback()
    }
    
    func updateIsPlaying() {
        isPlaying = !isPlaying
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
            nextTrack()
        }
    }
}
