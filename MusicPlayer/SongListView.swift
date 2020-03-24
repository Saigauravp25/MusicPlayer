//
//  SongListView.swift
//  MusicPlayer
//
//  Created by Saigaurav Purushothaman on 3/24/20.
//  Copyright © 2020 saipurush. All rights reserved.
//

import SwiftUI
import AVKit

struct SongListView: View {
    @EnvironmentObject var audioPlayer: AudioPlayer
    @State var songs: [String]
    @State var isPresented: Bool = false
    @State var whichPresented: Int = -1
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< songs.count) { i in
                    HStack {
                        Image("white-note")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .leading)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                        Button(action: {
                            self.isPresented.toggle()
                            self.whichPresented = i
                        }, label: {
                            Text(self.songs[i].fileName().capitalized)
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                        })
                            .frame(height: 50)
                    }
                }
            }
            .navigationBarTitle("Music Player", displayMode: .large)
        }
        .sheet(isPresented: $isPresented, content: {MusicPlayerView(songs: self.songs, songNum: self.whichPresented).environmentObject(self.audioPlayer)})
    }
}
