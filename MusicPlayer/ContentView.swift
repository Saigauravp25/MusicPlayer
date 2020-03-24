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
    @EnvironmentObject var audioPlayer: AudioPlayer
    @State var songs = ["bach.mp3", "beethoven.mp3", "chopin.wav", "brahms.mp3"]
    var body: some View {
        ZStack {
            SongListView(songs: self.songs).environmentObject(self.audioPlayer)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AudioPlayer())
    }
}
