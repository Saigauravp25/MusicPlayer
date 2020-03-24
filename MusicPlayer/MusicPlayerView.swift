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
    @State var songs: [String]
    @State var songNum: Int
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("cover-note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding(.all)
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
            self.audioPlayer.songNum = self.songNum
            self.audioPlayer.initPlayback()
            self.audioPlayer.startPlayback()
        }
    }
}

