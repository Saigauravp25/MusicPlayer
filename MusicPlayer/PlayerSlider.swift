//
//  PlayerSlider.swift
//  MusicPlayer
//
//  Created by Saigaurav Purushothaman on 3/23/20.
//  Copyright © 2020 saipurush. All rights reserved.
//

import SwiftUI

struct PlayerSlider: View {
    @EnvironmentObject var player: AudioPlayer
    @State private var currentPlayerTime: Double = 0.0
    var body: some View {
        VStack {
            HStack {
                Text("\(self.currentPlayerTime.toTimeString())")
                    .foregroundColor(.white)
                Spacer()
                Text("\(self.player.songDuration.toTimeString())")
                    .foregroundColor(.white)
            }
            HStack {
                GeometryReader { geometry in
                    Slider(value: self.$currentPlayerTime, in: 0.0...self.player.songDuration)
                        .onReceive(self.player.currentTimeInSecondsPassed) { _ in
                            self.currentPlayerTime = self.player.currentTimeInSeconds
                        }
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ value in
                                let percent = abs(Double(value.location.x) / Double(geometry.size.width))
                                self.player.playAtTime(time: self.player.songDuration * percent)
                            })
                        )
                }
                .frame(height: 50)
            }
        }
    }
}
