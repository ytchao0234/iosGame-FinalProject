//
//  AuthView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/12.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var auth: UserViewModel
    @FocusState var focus: Bool

    var body: some View {
        ZStack {
            Image("backgroundCats")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()
                .onTapGesture {
                    self.focus = false
                }

            UserView(type: "Log In")
                .overlay {
                    if auth.isLoading {
                        ProgressView()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                }
                .focused($focus)
        }
    }
}

struct UserView: View {
    @EnvironmentObject var auth: UserViewModel
    @State var type: String
    
    var isLogIn: Bool {
        return self.type == "Log In"
    }

    var body: some View {
        VStack {
            Group {
                TextField(text: $auth.user.email, prompt: Text("Email")) {}
                    .modifier(TextFieldViewModifier(image: "envelope.circle.fill"))
                PasswordView(isConfirming: false)
                
                if !isLogIn {
                    PasswordView(isConfirming: true)
                }
                
            }
            .padding(5)

            HStack {
                Button("Log In") {
                    if isLogIn {
                        auth.logIn()
                    } else {
                        self.type = "Log In"
                    }
                }
                .modifier(ButtonViewModifier(shape: RoundedRectangle(cornerRadius: 5), background: .blue, toStroke: !isLogIn))
                Button("Register") {
                    if !isLogIn {
                        auth.register()
                    } else {
                        self.type = "Register"
                    }
                }
                .modifier(ButtonViewModifier(shape: RoundedRectangle(cornerRadius: 5), background: .green, toStroke: isLogIn))
            }
            .padding(.top)
        }
        .padding(10)
        .padding(.vertical)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        .padding()
    }
}

struct PasswordView: View {
    @EnvironmentObject var auth: UserViewModel
    let isConfirming: Bool
    @State private var showPassword: Bool = false
    
    var promptText: String {
        return isConfirming ? "Confirm Password" : "Password"
    }
    var image: String {
        return isConfirming ? "lock.circle" : "lock.circle.fill"
    }
    var content: Binding<String> {
        return isConfirming ? $auth.user.confirmPwd : $auth.user.password
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if showPassword {
                TextField(text: content, prompt: Text(promptText)) {}
                    .modifier(TextFieldViewModifier(image: image))
            }
            else {
                SecureField(text: content, prompt: Text(promptText)) {}
                    .modifier(TextFieldViewModifier(image: image))
            }
            
            Image(systemName: (showPassword) ? "eye" : "eye.slash")
                .padding(.trailing)
                .onTapGesture {
                    showPassword.toggle()
                }
        }
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

struct ButtonViewModifier<T: Shape>: ViewModifier {
    let shape: T
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
            .background((toStroke) ? Color.clear : background)
            .clipShape(shape)
            .overlay(shape.stroke(foreground))
    }
}
