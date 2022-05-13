//
//  UserSettingView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct UserSettingView: View {
    @EnvironmentObject var auth: AuthViewModel
    @Binding var user: User

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HeadshotView(user: user)
                    .frame(width: 200, height: 200)
                
                ColorPicker(selection: $user.headshot.backgroundColor) {
                    TextField(text: $user.name, prompt: Text(user.name)) {}
                        .modifier(TextFieldViewModifier(image: "person.circle.fill"))
                }
                .frame(width: 200)

                HeadshotSettingView(user: $user)
                    .padding()
            }
        }
        .onAppear {
            self.user = auth.user
        }
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView(user: .constant(User()))
    }
}
