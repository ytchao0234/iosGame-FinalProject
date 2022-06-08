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

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    HeadshotView(userDetail: userDetail, size: 200)
                    
                    Button {
                        userDetail.headshot = Headshot.random()
                    } label: {
                        Image(systemName: "dice.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .frame(width: 40)
                    }
                    .modifier(ButtonViewModifier(shape: Circle(), background: .blue, toStroke: false))
                }
                .frame(width: 200, height: 200)
                
                List {
                    Group {
                        TextField(text: $userDetail.name, prompt: Text(userDetail.name)) {}
                            .modifier(TextFieldViewModifier(image: "person.circle.fill"))
                        HeadshotSettingView(headshot: $userDetail.headshot)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .onAppear {
            self.userDetail = auth.user.detail
        }
        .onChange(of: auth.user.detail.uid) { newValue in
            self.userDetail = auth.user.detail
        }
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView(userDetail: .constant(UserDetail()))
    }
}
