//
//  UserSettingView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct UserSettingView: View {
    @EnvironmentObject var auth: UserViewModel
    @Binding var userDetail: UserDetail
    @State var color: Color = .clear

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HeadshotView(userDetail: userDetail, size: 200)
                    .frame(width: 200, height: 200)

                ColorPicker(selection: $color) {
                    TextField(text: $userDetail.name, prompt: Text(userDetail.name)) {}
                        .modifier(TextFieldViewModifier(image: "person.circle.fill"))
                }
                .frame(width: 200)
                .onChange(of: color) { value in
                    if let rgba = UIColor(color).cgColor.components {
                        userDetail.headshot.backgroundRed = rgba[0]
                        userDetail.headshot.backgroundGreen = rgba[1]
                        userDetail.headshot.backgroundBlue = rgba[2]
                    }
                }

                HeadshotSettingView(headshot: $userDetail.headshot)
                    .padding()
            }
        }
        .onAppear {
            self.userDetail = auth.user.detail
            self.color = userDetail.headshot.backgroundColor
        }
        .onChange(of: auth.user.detail.uid) { newValue in
            self.userDetail = auth.user.detail
            self.color = userDetail.headshot.backgroundColor
        }
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView(userDetail: .constant(UserDetail()))
    }
}
