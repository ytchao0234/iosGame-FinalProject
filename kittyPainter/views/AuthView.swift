//
//  AuthView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var auth: UserViewModel

    var body: some View {
        ZStack {
            Image("backgroundCats")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()

            UserLogInView()
        }
    }
}

struct UserLogInView: View {
    @EnvironmentObject var auth: UserViewModel
    @State private var showPassword: Bool = false

    var body: some View {
        VStack {
            Group {
                TextField(text: $auth.user.email, prompt: Text("Email")) {}
                    .modifier(TextFieldViewModifier(image: "envelope.circle.fill"))
                
                ZStack(alignment: .trailing) {
                    if showPassword {
                        TextField(text: $auth.user.password, prompt: Text("Password")) {}
                            .modifier(TextFieldViewModifier(image: "lock.circle.fill"))
                    }
                    else {
                        SecureField(text: $auth.user.password, prompt: Text("Password")) {}
                            .modifier(TextFieldViewModifier(image: "lock.circle.fill"))
                    }
                    
                    Image(systemName: (showPassword) ? "eye" : "eye.slash")
                        .padding(.trailing)
                        .onTapGesture {
                            showPassword.toggle()
                        }
                }
            }
            .padding(5)

            HStack {
                Button("Log In") {
                    auth.logIn()
                }
                .modifier(ButtonViewModifier(background: .blue, toStroke: false))
                Button("Register") {
                    auth.register()
                }
                .modifier(ButtonViewModifier(background: .green, toStroke: true))
            }
            .padding(.top)
        }
        .padding(10)
        .padding(.vertical)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        .padding()
    }
}

struct TextFieldViewModifier: ViewModifier {
    let image: String
    let color = Color(red: 0.8, green: 0.75, blue: 0.7).opacity(0.5)

    func body(content: Content) -> some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .background(.ultraThinMaterial, in: Circle())
                .frame(width: 25, height: 25)
                .padding(.trailing, 5)
            content
                .frame(height: 25)
                .padding(5)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke())
            Spacer()
        }
    }
}

struct ButtonViewModifier: ViewModifier {
    let background: Color
    let toStroke: Bool

    func body(content: Content) -> some View {
        var foreground = Color.white

        if toStroke {
            foreground = background
        }

        return content
            .padding(5)
            .foregroundColor(foreground)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(foreground))
            .background((toStroke) ? Color.clear : background)
            .padding(5)
    }
}
