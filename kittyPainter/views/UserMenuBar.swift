//
//  UserMenuBar.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct UserMenuBar: View {
    @EnvironmentObject var auth: UserViewModel
    @Binding var mainView: MainView.CONNENT
    let userDetail: UserDetail

    var body: some View {
        HStack {
            Image(systemName: "house.circle.fill")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.8)
                .onTapGesture {
                    mainView = .Home
                }
            
            Spacer()

            switch(mainView) {
            case .UserSetting:
                Button("Save") {
                    auth.user.detail = userDetail
                    auth.user.detail.headshot.uploadPhoto(uid: auth.user.uid) { result in
                        switch(result) {
                        case .success(let url):
                            auth.user.detail.photoURL = url
                        case .failure(let error):
                            print(error)
                        }
                        auth.updateUserDetail()
                    }
                }
                .modifier(ButtonViewModifier(shape: RoundedRectangle(cornerRadius: 5), background: .green, toStroke: true))
                .transition(.offset(x: 50).combined(with: .opacity))
            default:
                EmptyView()
            }
            
            Button("Log Out") {
                auth.logOut()
            }
            .modifier(ButtonViewModifier(shape: RoundedRectangle(cornerRadius: 5), background: .blue, toStroke: false))
            HeadshotView(userDetail: auth.user.detail, size: 50)
                .onTapGesture {
                    mainView = .UserSetting
                }
        }
        .animation(.easeOut(duration: 0.5), value: mainView)
        .frame(height: 50)
        .padding(5)
    }
}

struct UserMenuBar_Previews: PreviewProvider {
    static var previews: some View {
        UserMenuBar(mainView: .constant(.Home), userDetail: UserDetail())
    }
}
