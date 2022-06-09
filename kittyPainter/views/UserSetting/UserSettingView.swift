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
    @FocusState var focus: Bool

    var body: some View {
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
            
            Form {
                Section {
                    Group {
                        TextField(text: $userDetail.name, prompt: Text(userDetail.name)) {}
                            .modifier(TextFieldViewModifier(image: "person.circle.fill"))
                            .focused($focus)
                        HeadshotSettingView(headshot: $userDetail.headshot)
                    }
                    .padding(.vertical, 5)
                } header: {
                    Label("Modifiable Information", systemImage: "pencil.and.outline")
                        .font(.caption)
                }
                Section {
                    Group {
                        FixedInformation(title: "Email", content: auth.user.email)
                        FixedInformation(title: "Joined Time", content: auth.user.detail.joinTime.formatted(.dateTime))
                        FixedInformation(title: "Accuracy Rate", content: "\(auth.user.detail.accuracyRate)%")
                        HStack {
                            Text("Hints")
                            Spacer()
                            ForEach(0..<UserDetail.maxHints) { idx in
                                Image(systemName: "lightbulb.fill")
                                    .foregroundColor((idx < auth.user.detail.hints) ? .yellow : .secondary)
                            }
                            Image(systemName: "play.rectangle")
                                .foregroundColor(.blue)
                                .padding(.leading, 5)
                                .onTapGesture {
                                    print("Ad")
                                }
                        }
                    }
                    .padding(.vertical, 5)
                } header: {
                    Label("Fixed Information", systemImage: "info.circle")
                        .font(.caption)
                }

            }
        }
        .onAppear {
            self.userDetail = auth.user.detail
        }
        .onChange(of: auth.user.detail.uid) { newValue in
            self.userDetail = auth.user.detail
        }
        .background(
            Color.clear
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    focus = false
                }
        )
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView(userDetail: .constant(UserDetail()))
    }
}

struct FixedInformation: View {
    let title: String
    let content: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(content)
        }
    }
}
