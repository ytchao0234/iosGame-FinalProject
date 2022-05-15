//
//  User.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User {
    var uid: String = ""
    var email: String = ""
    var password: String = ""
    var detail = UserDetail()
}

struct UserDetail: Codable, Identifiable {
    @DocumentID var id: String?
    var uid: String = ""
    var name: String = "Anonymous"
    var headshot: Headshot = Headshot()
}
