//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Saigaurav Purushothaman on 3/19/20.
//  Copyright © 2020 saipurush. All rights reserved.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var isPlaying: Bool = false
    @State var songNum: Int = 0
    @State var songs = ["bach.mp4", "beethoven.mp3", "chopin.wav", "brahms.m4a"]
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Music Player").font(.system(size: 45)).fontWeight(.bold)
                        .foregroundColor(.buttonColor)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.songNum = (self.songs.count + self.songNum - 1) % self.songs.count
                        self.audioPlayer.stop()
                        let song = self.songs[self.songNum]
                        let sound = Bundle.main.path(forResource: song.fileName(), ofType: song.fileExtension())
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default , options: [AVAudioSession.CategoryOptions.mixWithOthers])
                        self.audioPlayer.play()
                        self.isPlaying = true
                    }, label: {
                        Image(systemName: "backward.fill").resizable()
                            .frame(width: 75, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.buttonColor)
                    })
                    Spacer()
                    Button(action: {
                        if self.isPlaying {
                            self.audioPlayer.pause()
                        } else {
                            self.audioPlayer.play()
                        }
                        self.isPlaying = !self.isPlaying
                    }, label: {
                        Image(systemName: "\(self.isPlaying ? "pause" : "play").fill").resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.buttonColor)
                    })
                    Spacer()
                    Button(action: {
                        self.songNum = (self.songNum + 1) % self.songs.count
                        self.audioPlayer.stop()
                        let song = self.songs[self.songNum]
                        let sound = Bundle.main.path(forResource: song.fileName(), ofType: song.fileExtension())
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default , options: [AVAudioSession.CategoryOptions.mixWithOthers])
                        self.audioPlayer.play()
                        self.isPlaying = true
                    }, label: {
                        Image(systemName: "forward.fill").resizable()
                            .frame(width: 75, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.buttonColor)
                    })
                    Spacer()
                }
            }
        }
        .onAppear {
            let song = self.songs[self.songNum]
            let sound = Bundle.main.path(forResource: song.fileName(), ofType: song.fileExtension())
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default , options: [AVAudioSession.CategoryOptions.mixWithOthers])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
