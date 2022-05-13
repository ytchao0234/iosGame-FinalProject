//
//  kittyPainterApp.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI
import Firebase

@main
struct kittyPainterApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
