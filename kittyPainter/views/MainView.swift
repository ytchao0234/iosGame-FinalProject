//
//  MainView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State var content: MainView.CONNENT = .UserSetting
    @State var tempUser: User = User()

    var body: some View {
        VStack {
            UserMenuBar(mainView: $content, tempUser: tempUser)
            Spacer()

            switch(content) {
            case .Home:
                Text("Home")
            case .UserSetting:
                UserSettingView(user: $tempUser)
            }
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    enum CONNENT {
        case Home, UserSetting
    }
}
