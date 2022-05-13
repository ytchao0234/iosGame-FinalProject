//
//  HeadshotSettingView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct HeadshotSettingView: View {
    @Binding var user: User
    @State private var selection: Int = 0

    var body: some View {
        VStack {
            Picker("headshot picker", selection: $selection) {
                Text("Shape").tag(0)
                Text("Pattern").tag(1)
                Text("Eyes").tag(2)
            }
            .pickerStyle(.segmented)
            TabView(selection: $selection) {
                SelectView(list: Headshot.shapeList, idx: $user.headshot.shape).tag(0)
                SelectView(list: Headshot.patternList, idx: $user.headshot.pattern).tag(1)
                SelectView(list: Headshot.eyesList, idx: $user.headshot.eyes,
                           clippedAlignment: .leading, clippedOffset: CGSize(width: 0, height: 15)).tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct HeadshotSettingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadshotSettingView(user: .constant(User()))
    }
}

struct SelectView: View {
    let list: Array<String>
    @Binding var idx: Int
    let clippedAlignment: Alignment?
    let clippedOffset: CGSize
    
    init(list: Array<String>, idx: Binding<Int>, clippedAlignment: Alignment? = nil, clippedOffset: CGSize = .zero) {
        self.list = list
        self._idx = Binding(projectedValue: idx)
        self.clippedAlignment = clippedAlignment
        self.clippedOffset = clippedOffset
    }
    
    func getImageSize(_ imageName: String) -> CGSize {
        let image = UIImage(named: imageName)!
        let width = image.size.width
        let height = image.size.height
        
        return CGSize(width: width, height: height)
    }

    var body: some View {
        let columns = [GridItem(.adaptive(minimum: 80, maximum: 80))]

        LazyVGrid(columns: columns) {
            ForEach(Array(list.indices), id: \.self) { idx in
                let imageSize = getImageSize(list[idx])

                Group {
                    if let alignment = clippedAlignment {
                        Image(list[idx])
                            .frame(width: imageSize.width / 2, height: imageSize.height / 2, alignment: alignment)
                            .offset(clippedOffset)
                            .clipped()
                            .frame(width: 80, height: 80 * imageSize.height / imageSize.width)
                    }
                    else {
                        Image(list[idx])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                    }
                }
                .background(Color.secondary)
                .overlay {
                    if idx == self.idx {
                        Rectangle()
                            .stroke(.yellow, lineWidth: 2)
                            .blur(radius: 2.5)
                    }
                }
                .onTapGesture {
                    self.idx = idx
                }
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
    }
}
