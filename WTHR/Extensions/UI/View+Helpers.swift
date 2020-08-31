//
//  View+Helpers.swift
//  WTHR
//
//  Created by Гена Книжник on 18.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import SwiftUI

private struct LazyView<Content: View>: View {
    
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
    
}

// MARK: - Lazy Init

extension View {
    var lazy: some View {
        LazyView(self)
    }
}

// MARK: - Modifiers

extension View {
    
    // MARK: Navigation
    
    func leadingNavigationComponent() -> some View {
        self.modifier(NavigationComponent(edges: .leading))
    }
    
    func trailingNavigationComponent() -> some View {
        self.modifier(NavigationComponent(edges: .trailing))
    }
    
    // MARK: Background
    
    func backgroundLayer() -> some View {
        self.modifier(BackgroundLayer())
    }
    
    // MARK: Shadow
    
    func shadowShape() -> some View {
        self.modifier(ShadowShape())
    }
    
    // MARK: Text
    
    func largeTitleTextStyle() -> some View {
        self.modifier(LargeTitle())
    }
    
    func title1TextStyle() -> some View {
        self.modifier(Title1())
    }
    
    func title2TextStyle() -> some View {
        self.modifier(Title2())
    }
    
    func lightTitle3TextStyle() -> some View {
        self.modifier(Title3(color: .white))
    }
    
    func darkHeadlineTextStyle() -> some View {
        self.modifier(Headline(color: .mediumDarkText))
    }
    
    func darkSubheadlineTextStyle() -> some View {
        self.modifier(Subheadline(color: .lightDarkText))
    }
    
    func lightFootnoteTextStyle() -> some View {
        self.modifier(Footnote(color: .white))
    }
    
    func lightCaptionTextStyle() -> some View {
        self.modifier(Caption(color: .white))
    }
    
    func darkCaptionTextStyle() -> some View {
        self.modifier(Caption(color: .mediumDarkText))
    }
    
}
