//
//  UIFont+Customizing.swift
//  WTHR
//
//  Created by Гена Книжник on 31.08.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import UIKit

extension UIFont {
    
    static var navigationFont: UIFont {
        UIFont.preferredFont(forTextStyle: .largeTitle).bold()
    }
    
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)?.withDesign(.rounded)
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
}
