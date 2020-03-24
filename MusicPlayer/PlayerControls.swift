//
//  PlayerControls.swift
//  MusicPlayer
//
//  Created by Saigaurav Purushothaman on 3/23/20.
//  Copyright © 2020 saipurush. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerControls: View {
    @EnvironmentObject var audioPlayer: AudioPlayer
    var body: some View {
        HStack {
            Spacer()
            Button(action: {self.audioPlayer.previousTrack()}, label: {
                Image(systemName: "backward.fill")
                    .resizable()
                    .frame(width: 75, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.buttonColor)
            })
            Spacer()
            Button(action: {self.audioPlayer.playPauseTrack()}, label: {
                Image(systemName: "\(self.audioPlayer.isPlaying ? "pause" : "play").fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.buttonColor)
            })
            Spacer()
            Button(action: {self.audioPlayer.nextTrack()}, label: {
                Image(systemName: "forward.fill")
                    .resizable()
                    .frame(width: 75, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.buttonColor)
            })
            Spacer()
        }
    }
}
