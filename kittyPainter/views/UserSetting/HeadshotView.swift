//
//  HeadshotView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct HeadshotView: View {
    let user: User

    var body: some View {
        ZStack {
            Group {
                Image(user.headshot.baseString)
                    .resizable()
                Image(user.headshot.eyesString)
                    .resizable()
            }
            .scaledToFit()
        }
        .scaleEffect(0.8)
        .background(user.headshot.backgroundColor)
        .clipShape(Circle())
    }
}

struct HeadshotView_Previews: PreviewProvider {
    static var previews: some View {
        HeadshotView(user: User())
    }
}
