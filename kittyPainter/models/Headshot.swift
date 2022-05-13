//
//  Headshot.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct Headshot {
    var backgroundColor: Color = .white
    var shape: Int = 0
    var pattern: Int = 0
    var eyes: Int = 0
    
    var shapeString: String {
        "shape\(self.shape)"
    }
    var patternString: String {
        "pattern\(self.pattern)"
    }
    var baseString: String {
        "base\(self.shape)\(self.pattern)"
    }
    var eyesString: String {
        "eyes\(self.eyes)"
    }
}

extension Headshot {
    static let shapeList: Array<String> = Array(0...1).map { "shape\($0)" }
    static let patternList: Array<String> = Array(0...1).map { "pattern\($0)" }
    static let eyesList: Array<String> = Array(0...2).map { "eyes\($0)" }
}
