//
//  HeadshotSettingView.swift
//  kittyPainter
//
//  Created by FanRende on 2022/5/13.
//

import SwiftUI

struct HeadshotSettingView: View {
    @Binding var headshot: Headshot
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
                SelectView(headshot: $headshot, selection: $headshot.shape, type: "shape", list: Headshot.getShapeList(headshot.shape)).tag(0)
                SelectView(headshot: $headshot, selection: $headshot.pattern, type: "pattern", list: Headshot.getPatternList(headshot.shape)).tag(1)
                SelectView(headshot: $headshot, selection: $headshot.eyes, type: "eyes", list: Headshot.getEyesList(headshot.shape),
                           clippedAlignment: .leading, clippedOffset: CGSize(width: 0, height: 15)).tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct HeadshotSettingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadshotSettingView(headshot: .constant(Headshot()))
    }
}

struct SelectView: View {
    @Binding var headshot: Headshot
    @Binding var selection: Int
    let type: String
    let list: Array<Int>
    let clippedAlignment: Alignment?
    let clippedOffset: CGSize
    
    init(headshot: Binding<Headshot>, selection: Binding<Int>, type: String, list: Array<Int>, clippedAlignment: Alignment? = nil, clippedOffset: CGSize = .zero) {
        self._headshot = Binding(projectedValue: headshot)
        self._selection = Binding(projectedValue: selection)
        self.type = type
        self.list = list
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
                let imageSize = getImageSize(type + "\(list[idx])")

                Group {
                    if let alignment = clippedAlignment {
                        Image(type + "\(list[idx])")
                            .frame(width: imageSize.width / 2, height: imageSize.height / 2, alignment: alignment)
                            .offset(clippedOffset)
                            .clipped()
                            .frame(width: 80, height: 80 * imageSize.height / imageSize.width)
                    }
                    else {
                        Image(type + "\(list[idx])")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                    }
                }
                .background(Color.secondary)
                .overlay {
                    if list[idx] == self.selection {
                        Rectangle()
                            .stroke(.yellow, lineWidth: 2)
                            .blur(radius: 2.5)
                    }
                }
                .onTapGesture {
                    if type == "shape" {
                        headshot.pattern = 0
                    }
                    self.selection = list[idx]
                }
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
    }
}
