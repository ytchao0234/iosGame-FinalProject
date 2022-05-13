//
//  UserMenuBar.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct UserMenuBar: View {
    @EnvironmentObject var auth: AuthViewModel
    @Binding var mainView: MainView.CONNENT
    let tempUser: User

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
                    auth.user = tempUser
                }
                .modifier(ButtonViewModifier(background: .green, toStroke: true))
                .transition(.offset(x: 50).combined(with: .opacity))
            default:
                EmptyView()
            }
            
            Button("Log Out") {
                auth.logOut()
            }
            .modifier(ButtonViewModifier(background: .blue, toStroke: false))
            HeadshotView(user: auth.user)
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
        UserMenuBar(mainView: .constant(.Home), tempUser: User())
    }
}
