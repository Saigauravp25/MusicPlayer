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
    
    static let backgroundColor = Color.rgb(r: 21, g: 22, b: 23)
    static let buttonColor = Color.rgb(r: 15, g: 175, b: 220)
}

extension String {
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() ->String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
