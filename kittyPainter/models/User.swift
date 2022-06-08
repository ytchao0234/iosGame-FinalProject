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
    var detail = UserDetail()
}

struct UserDetail: Codable, Identifiable {
    @DocumentID var id: String?
    var uid: String = ""
    var name: String = "Anonymous"
    var joinTime: Date = .now
    var headshot: Headshot = Headshot()
    var photoURL: URL? = nil
}
