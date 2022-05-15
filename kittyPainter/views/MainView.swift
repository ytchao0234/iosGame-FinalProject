//
//  MainView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MainView: View {
    @EnvironmentObject var auth: UserViewModel
    @State var content: MainView.CONNENT = .UserSetting
    @State var tempUserDetail: UserDetail = UserDetail()

    var body: some View {
        VStack {
            UserMenuBar(mainView: $content, userDetail: tempUserDetail)
            Spacer()

            switch(content) {
            case .Home:
                Text("Home")
            case .UserSetting:
                UserSettingView(userDetail: $tempUserDetail)
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
