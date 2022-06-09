//
//  UserViewModel.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class UserViewModel: ObservableObject {
    @Published var user: User = User()
    @Published var isLoggedIn: Bool = false
    @Published var toAlert: Bool = false
    @Published var errorMessage: String = ""

    @Published var isLoading: Bool = false
    @Published var isSaving: Bool = false

    init() {
        self.checkIsLoggedIn()
    }

    func register() {
        self.isLoading = true

        if self.user.password != self.user.confirmPwd {
            self.toAlert = true
            self.errorMessage = "[ERROR]: Register : Password are not matching."
            self.isLoading = false
            return
        }

        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
                    
            guard let user = result?.user,
                error == nil else {
                self.toAlert = true
                self.errorMessage = "[ERROR]: Register : \(error?.localizedDescription ?? "Error description is nil.")"
                return
            }
            self.user.uid = user.uid
            self.user.detail = UserDetail(uid: user.uid)
            self.updateUserDetail()
            self.uploadHeadshot() {
                self.logIn()
            }
        }
    }

    func logIn() {
        self.isLoading = true

        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            guard let user = result?.user,
                error == nil else {
                self.toAlert = true
                self.errorMessage = "[ERROR]: Log In : \(error?.localizedDescription ?? "Error description is nil.")"
                return
            }
            self.isLoggedIn = true
            self.user.uid = user.uid
            print(user.email ?? "user email", user.uid)
            self.setHeadshotImage()
            self.readUserDetail()
            self.isLoading = false
        }
    }
    
    func logOut() {
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
            self.setHeadshotImage()
            self.readUserDetail()
        } else {
            self.isLoggedIn = false
        }
    }

    func updateUserDetail() {
        let db = Firestore.firestore()
        do {
            self.user.detail.uid = self.user.uid
            try db.collection("UserDetail").document(self.user.uid).setData(from: self.user.detail)
        } catch {
            print(error)
        }
    }

    func readUserDetail() {
        let db = Firestore.firestore()
        
        db.collection("UserDetail").document(self.user.uid).getDocument { document, error in
            guard let document = document,
                  document.exists,
                  let userDetail = try? document.data(as: UserDetail.self) else {
                return
            }
            self.user.detail = userDetail
        }
    }
    
    func uploadHeadshot(completion: () -> Void) {
        self.user.detail.headshot.uploadPhoto(uid: self.user.uid) { result in
            switch(result) {
            case .success(let url):
                self.user.detail.photoURL = url
                self.setHeadshotImage()
            case .failure(let error):
                print(error)
            }
        }
        completion()
    }
    
    func setHeadshotImage() {
        let fileReference = Storage.storage().reference().child(self.user.uid + ".png")
        fileReference.getData(maxSize: 10 * 1024 * 1024) { result in
            switch result {
            case .success(let data):
                self.user.headshotImage = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
            self.isSaving = false
        }
    }
}
