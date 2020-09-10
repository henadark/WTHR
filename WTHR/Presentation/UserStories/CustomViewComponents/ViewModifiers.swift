//
//  ViewModifiers.swift
//  WTHR
//
//  Created by Гена Книжник on 30.06.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

// MARK: - View

struct BackgroundLayer: ViewModifier {
    
    func body(content: Content) -> some View {
        Color.mainBackground
            .edgesIgnoringSafeArea(.all)
            .overlay(content)
    }
    
}

struct ShadowShape: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .shadow, radius: 23, y: 10)
    }
    
}

// MARK: - Button

struct NavigationComponent: ViewModifier {
    
    let edges: Edge.Set
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.darkText)
            .font(.title)
            .padding(edges)
        
    }
}

// MARK: - Text

struct LargeTitle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .largeTitleFontSize, weight: .bold, design: .rounded))
            .foregroundColor(.darkText)
        
    }
}

struct Title1: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .title1FontSize, weight: .bold, design: .rounded))
            .foregroundColor(.darkText)
        
    }
}

struct Title2: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .title2FontSize, weight: .bold, design: .rounded))
            .foregroundColor(.darkText)
        
    }
}

struct Title3: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .title3FontSize, weight: .bold, design: .rounded))
            .foregroundColor(color)
        
    }
}

struct Headline: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .headlineFontSize, weight: .medium, design: .rounded))
            .foregroundColor(color)
        
    }
}

struct Subheadline: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .subheadlineFontSize, weight: .regular, design: .rounded))
            .foregroundColor(color)
        
    }
}

struct Footnote: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .footnoteFontSize, weight: .semibold, design: .rounded))
            .foregroundColor(color)
        
    }
}

struct Caption: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: .captionFontSize, weight: .bold, design: .rounded))
            .foregroundColor(color)
        
    }
}
