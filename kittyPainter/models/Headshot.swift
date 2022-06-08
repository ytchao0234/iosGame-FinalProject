//
//  Headshot.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI
import FirebaseStorage

struct Headshot: Codable {
    var backgroundRed: Double = 1
    var backgroundGreen: Double = 1
    var backgroundBlue: Double = 1
    var shape: Int = 0
    var pattern: Int = 0
    var eyes: Int = 0
    var extraEyesOffset: CGSize = .zero

    var backgroundColor: Color {
        get {
            Color(red: backgroundRed, green: backgroundGreen, blue: backgroundBlue)
        }
        set(color) {
            if let rgba = UIColor(color).cgColor.components {
                self.backgroundRed = rgba[0]
                self.backgroundGreen = rgba[1]
                self.backgroundBlue = rgba[2]
            }
        }
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
            return CGSize(width: 1 + extraEyesOffset.width, height: 0 + extraEyesOffset.height)
        }
        else {
            return extraEyesOffset
        }
    }
    
    func getUIImage() -> UIImage {
        Image(self.baseString)
            .resizable()
            .scaledToFit()
            .overlay {
                Image(self.eyesString)
                    .resizable()
                    .scaledToFit()
                    .offset(eyesOffset)
            }
            .scaleEffect(0.8)
            .background(self.backgroundColor)
            .clipShape(Circle())
            .ignoresSafeArea()
            .snapshot()
    }

    func uploadPhoto(uid: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let image = self.getUIImage()

        let fileReference = Storage.storage().reference().child(uid + ".png")
        if let data = image.jpegData(compressionQuality: 0.9) {
            
            fileReference.putData(data, metadata: nil) { result in
                switch result {
                case .success(_):
                     fileReference.downloadURL(completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

extension Headshot {
    static let shapeRange = 0...3
    static let patternRange = 0...13
    static let eyesRange = 0...6

    static func random() -> Headshot {
        let shape = Int.random(in: Headshot.shapeRange)

        return Headshot(backgroundRed: Double.random(in: 0...1), backgroundGreen: Double.random(in: 0...1), backgroundBlue: Double.random(in: 0...1), shape: shape, pattern: Headshot.getPatternList(shape).randomElement()!, eyes: Int.random(in: Headshot.eyesRange))
    }
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
            patternList = Array(patternRange)
        }
        return patternList
    }
    static func getEyesList(_ shape: Int) -> Array<Int> {
        return Array(0...6)
    }
}
