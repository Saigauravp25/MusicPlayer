//
//  MusicPlayerView.swift
//  MusicPlayer
//
//  Created by Saigaurav Purushothaman on 3/22/20.
//  Copyright © 2020 saipurush. All rights reserved.
//

import SwiftUI
import AVKit

struct MusicPlayerView: View {
    @EnvironmentObject var audioPlayer: AudioPlayer
    @State var songs = ["bach.mp3", "beethoven.mp3", "chopin.wav", "brahms.mp3"]
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("\(self.songs[self.audioPlayer.songNum].fileName().capitalized)")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.buttonColor)
                }
                PlayerSlider()
                    .padding(.horizontal)
                PlayerControls()
            }
        }
        .onAppear {
            self.audioPlayer.songs = self.songs
            self.audioPlayer.initPlayback()
        }
    }
}

