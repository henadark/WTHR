//
//  ComparativeView.swift
//  WTHR
//
//  Created by Гена Книжник on 26.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

typealias ComparativeInfoParams = (leftName: String, leftDescription: String, rightName: String, rightDescription: String)

struct ComparativeView: View {
    
    let params: ComparativeInfoParams
    
    var body: some View {
        HStack {
            leftInfoView
            VerticalLine()
                .stroke(Color.grayLine)
                .frame(width: .dividerLineWidth)
            rightInfoView
        }
        .padding(.vertical)
        .shadowShape()
    }
    
}

// MARK: - Subviews

private extension ComparativeView {
    
    var leftInfoView: some View {
        stackInfoView(name: params.leftName, description: params.leftDescription)
    }
    
    var rightInfoView: some View {
        stackInfoView(name: params.rightName, description: params.rightDescription)
    }
    
    func stackInfoView(name: String, description: String) -> some View {
        return VStack(spacing: .comparativeVStackSpacing) {
            Text(name)
                .darkSubheadlineTextStyle()
            Text(description)
            .title2TextStyle()
        }
        .frame(maxWidth: .infinity)
    }
    
}

struct ComparativeView_Previews: PreviewProvider {
    static var previews: some View {
        ComparativeView(params: ComparativeInfoParams(leftName: "Min temperature",
                                                      leftDescription: "2°",
                                                      rightName: "Max temperature",
                                                      rightDescription: "5°"))
            .frame(width: 330, height: 112)
    }
}
