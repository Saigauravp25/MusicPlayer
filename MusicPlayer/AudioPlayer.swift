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
    var player: AVAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "beethoven", ofType: "mp3")!))
    var songNum: Int = 0
    var songs: [String]!
    var timer: Timer!
    var isPlaying: Bool = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    var songDuration: Double = 0.0 {
        didSet {
            objectWillChange.send(self)
        }
    }
    var curTime: Double = 0.0 {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func initPlayback() {
        let song = songs[songNum]
        let sound = Bundle.main.path(forResource: song.fileName(), ofType: song.fileExtension())
        let playbackSession = AVAudioSession.sharedInstance()
        player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        try! playbackSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [AVAudioSession.CategoryOptions.mixWithOthers])
        player.delegate = self
        player.prepareToPlay()
        songDuration = Double(player.duration)
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {_ in self.updateCurrentTime()})
    }
    
    func updateCurrentTime() {
        curTime = Double(player.currentTime)
    }
    
    func startPlayback() {
        player.play()
        isPlaying = true
    }
    
    func pausePlayback() {
        player.pause()
        isPlaying = false
    }
    
    func stopPlayback() {
        player.stop()
        isPlaying = false
        timer.invalidate()
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
    
    func currentTimeInTrack() -> Double {
        return player.currentTime
    }
    
    func trackDuration() -> Double {
        return songDuration
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
            nextTrack()
        }
    }
}
