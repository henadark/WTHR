//
//  CapsuleGraphsView.swift
//  WTHR
//
//  Created by Гена Книжник on 28.07.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

typealias OnTapGestureAtIndex = (_ index: Int) -> ()

struct CapsuleGraphsView: View {
        
    let datas: [CapsuleGraphData]
    var onTapAtIndex: OnTapGestureAtIndex?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HorizontalLine()
                    .stroke(Color.grayLine, style: .dashLineStyle(size: geometry.size))
                HStack(spacing: 0) {
                    ForEach(0..<self.datas.count) { index in
                        CapsuleGraphView(data: self.datas[index],
                                         size: self.cupsuleSizeFor(frame: geometry.frame(in: .local)))
                            .onTapGesture {
                                self.onTapAtIndex?(index)
                        }
                    } // ForEach
                } // HStack
            } // ZStack
        } // GeometryReader
    }
    
}

// MARK: - Helpers

private extension CapsuleGraphsView {
    
    func cupsuleSizeFor(frame: CGRect) -> CGSize {
        return CGSize(width: frame.width / datas.count.cgFloat, height: frame.height)
    }
    
}

struct CapsuleGraphsView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleGraphsView(datas:
            [CapsuleGraphData(value: 0, min: -50, max: 50, title: "Sun"),
             CapsuleGraphData(value: 30, min: -50, max: 50, title: "Mon"),
             CapsuleGraphData(value: 34, min: -50, max: 50, title: "Tue"),
             CapsuleGraphData(value: -4, min: -50, max: 50, title: "Wed"),
             CapsuleGraphData(value: 18, min: -50, max: 50, title: "Thi")],
                          onTapAtIndex: nil)
            .frame(width: 320, height: 300)
    }
}
