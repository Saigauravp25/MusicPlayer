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
    @ObservedObject var audioPlayer = AudioPlayer()
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
                    Button(action: {self.audioPlayer.previousTrack()}, label: {
                        Image(systemName: "backward.fill").resizable()
                            .frame(width: 75, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.buttonColor)
                    })
                    Spacer()
                    Button(action: {self.audioPlayer.playPauseTrack()}, label: {
                        Image(systemName: "\(self.audioPlayer.isPlaying ? "pause" : "play").fill").resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.buttonColor)
                    })
                    Spacer()
                    Button(action: {self.audioPlayer.nextTrack()}, label: {
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
            self.audioPlayer.songs = self.songs
            self.audioPlayer.initPlayback()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
