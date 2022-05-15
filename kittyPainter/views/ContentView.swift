//
//  ContentView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI

struct ContentView: View {
    @StateObject var auth = UserViewModel()

    var body: some View {
        Group {
            if auth.isLoggedIn {
                MainView()
            }
            else {
                AuthView()
            }
        }
        .environmentObject(auth)
        .alert("Auth Error", isPresented: $auth.toAlert) {
            Button("OK") {}
        } message: {
            Text(auth.errorMessage)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
