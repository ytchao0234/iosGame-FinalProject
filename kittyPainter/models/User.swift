//
//  User.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User {
    var uid: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPwd: String = ""
    var headshotImage: UIImage? = nil
    var detail = UserDetail()
}

struct UserDetail: Codable, Identifiable {
    @DocumentID var id: String?
    var uid: String = ""
    var name: String = "Anonymous"
    var joinTime: Date = .now
    var correctAnswers: Int = 0
    var answers: Int = 0
    var hints: Int = 3
    var headshot: Headshot = Headshot()
    var photoURL: URL? = nil
    
    var accuracyRate: Double {
        if answers > 0 {
            return Double(correctAnswers/answers) * 100
        }
        else {
            return 0
        }
    }
}

extension UserDetail {
    static let maxHints: Int = 5
}
