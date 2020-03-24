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
    var body: some View {
        MusicPlayerView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AudioPlayer())
    }
}
