//
//  Headshot.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Headshot: Codable {
    var backgroundRed: Double = 1
    var backgroundGreen: Double = 1
    var backgroundBlue: Double = 1
    var shape: Int = 0
    var pattern: Int = 0
    var eyes: Int = 0

    var backgroundColor: Color {
        Color(red: backgroundRed, green: backgroundGreen, blue: backgroundBlue)
    }
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
    var eyesOffset: CGSize {
        if self.shape == 2 {
            return CGSize(width: 1, height: 0)
        }
        else {
            return .zero
        }
    }
}

extension Headshot {
    static func getShapeList(_ shape: Int) -> Array<Int> {
        return Array(0...3)
    }
    static func getPatternList(_ shape: Int = -1) -> Array<Int> {
        var patternList: Array<Int>

        switch(shape) {
        case 0:
            patternList = [0,1,2,3,4,5,6,9,10,11]
        case 1:
            patternList = [0,1,2,3,5]
        case 2:
            patternList = [0,1,2,3,6,7,8,12,13]
        case 3:
            patternList = [0,1,4,5,6,7,10]
        default:
            patternList = Array(0...13)
        }
        return patternList
    }
    static func getEyesList(_ shape: Int) -> Array<Int> {
        return Array(0...6)
    }
}
