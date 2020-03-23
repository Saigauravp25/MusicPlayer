//
//  Extension.swift
//  MusicPlayer
//
//  Created by Saigaurav Purushothaman on 3/19/20.
//  Copyright © 2020 saipurush. All rights reserved.
//

import SwiftUI

extension Color {
    
    static func rgb(r: Double, g: Double, b: Double) -> Color {
        return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
    
    static let backgroundColor = Color.rgb(r: 20, g: 20, b: 20)
    static let buttonColor = Color.rgb(r: 60, g: 120, b: 240)
}

extension String {
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() ->String {
        return URL(fileURLWithPath: self).pathExtension
    }
}

extension TimeInterval {
    
    func toString() -> String {
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
}
