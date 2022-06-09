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
                Button {
                    auth.isSaving = true
                    auth.user.detail = userDetail
                    auth.uploadHeadshot() {
                        auth.updateUserDetail()
                    }
                } label: {
                    if !auth.isSaving {
                        Text("Save")
                    }
                    else {
                        ProgressView()
                    }
                }
                .modifier(ButtonViewModifier(shape: RoundedRectangle(cornerRadius: 5), background: .green, toStroke: true))
                .transition(.offset(x: 50).combined(with: .opacity))
                .disabled(auth.isSaving)
            default:
                EmptyView()
            }
            
            Button("Log Out") {
                auth.logOut()
            }
            .modifier(ButtonViewModifier(shape: RoundedRectangle(cornerRadius: 5), background: .blue, toStroke: false))
            
            Group {
                if let headshot = auth.user.headshotImage {
                    Image(uiImage: headshot)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                } else {
                    ProgressView()
                        .frame(width: 45, height: 45)
                        .background(Color.secondary)
                        .clipShape(Circle())
                }
            }
            .onTapGesture {
                mainView = .UserSetting
            }
            .onChange(of: auth.user.headshotImage) { newValue in
                print(newValue)
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
