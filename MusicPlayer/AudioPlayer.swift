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
import AVKit

class AudioPlayer: AVPlayer, ObservableObject {
    @Published var currentTimeInSeconds: Double = 0.0
    var songDuration: Double = 0.0
    var songNum: Int = 0
    var songs: [String]!
    var isPlaying: Bool = false
    private var timeObserverToken: Any?
    var currentTimeInSecondsPassed: AnyPublisher<Double, Never>  {
        return $currentTimeInSeconds
            .eraseToAnyPublisher()
    }

    override init() {
        super.init()
        registerObserver()
    }

    private func registerObserver() {
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = self.addPeriodicTimeObserver(forInterval: interval, queue: .main) {
            [weak self] _ in
            self?.currentTimeInSeconds = self?.currentTime().seconds ?? 0.0
        }
    }

    func playAtTime(time seconds: Double) {
        self.seek(to: CMTime(seconds: seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
    }

    deinit {
        if let token = timeObserverToken {
            self.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    
    func initPlayback() {
        let song = songs[songNum]
        let sound = Bundle.main.path(forResource: song.fileName(), ofType: song.fileExtension())
        let playbackSession = AVAudioSession.sharedInstance()
        try! playbackSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [AVAudioSession.CategoryOptions.mixWithOthers])
        let playerItem = AVPlayerItem(asset: AVURLAsset(url: URL(fileURLWithPath: sound!)))
        self.replaceCurrentItem(with: playerItem)
        if let duration = self.currentItem?.asset.duration {
            self.songDuration = CMTimeGetSeconds(duration)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    @objc func playerItemDidPlayToEndTime() {
        nextTrack()
    }
    
    func startPlayback() {
        self.play()
        isPlaying = true
    }
    
    func pausePlayback() {
        self.pause()
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
        pausePlayback()
        initPlayback()
        startPlayback()
    }
    
    func nextTrack() {
        songNum = (songNum + 1) % songs.count
        pausePlayback()
        initPlayback()
        startPlayback()
    }
    
    func updateIsPlaying() {
        isPlaying.toggle()
    }
}
