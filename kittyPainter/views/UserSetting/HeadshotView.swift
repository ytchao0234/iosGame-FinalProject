//
//  HeadshotView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct HeadshotView: View {
    let userDetail: UserDetail
    let size: CGFloat
    
    var eyesOffset: CGSize {
        let width = userDetail.headshot.eyesOffset.width * size / 50
        let height = userDetail.headshot.eyesOffset.height * size / 50
        
        return CGSize(width: width, height: height)
    }

    var body: some View {
        if userDetail.uid != "" {
            Image(userDetail.headshot.baseString)
                .resizable()
                .scaledToFit()
                .overlay {
                    Image(userDetail.headshot.eyesString)
                        .resizable()
                        .scaledToFit()
                        .offset(eyesOffset)
                }
                .scaleEffect(0.8)
                .background(userDetail.headshot.backgroundColor)
                .clipShape(Circle())
        } else {
            ProgressView()
                .frame(width: size, height: size)
                .background(Color.secondary)
                .clipShape(Circle())
        }
    }
}

struct HeadshotView_Previews: PreviewProvider {
    static var previews: some View {
        HeadshotView(userDetail: UserDetail(), size: 200)
    }
}
