//
//  AuthViewModel.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User = User()
    @Published var isLoggedIn: Bool = false
    @Published var toAlert: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        self.checkIsLoggedIn()
    }
    
    func register() {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
                    
            guard let user = result?.user,
                error == nil else {
                self.toAlert = true
                self.errorMessage = "[ERROR]: Register : \(error?.localizedDescription ?? "Error description is nil.")"
                return
            }
            print(user.email ?? "user email", user.uid)
            self.logIn()
        }
    }

    func logIn() {
        print("logIn")
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            guard let user = result?.user,
                error == nil else {
                self.toAlert = true
                self.errorMessage = "[ERROR]: Log In : \(error?.localizedDescription ?? "Error description is nil.")"
                return
            }
            self.isLoggedIn = true
            print(user.email ?? "user email", user.uid)
        }
    }
    
    func logOut() {
        print("logOut")
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch {
            self.toAlert = true
            self.errorMessage = "[ERROR]: Log Out : \(error)"
        }
    }
    
    func checkIsLoggedIn() {
        if let user = Auth.auth().currentUser {
            self.user.uid = user.uid
            self.user.email = user.email ?? ""
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
}
