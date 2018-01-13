//
//  Theme.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 13/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class Theme {
    
    let visuals: Visuals
    
    init(visuals: Visuals) {
        self.visuals = visuals
    }
}

// MARK: - Visuals
public struct Visuals {
    
    // Typefaces
    public enum Typeface : String {
        case titleFont = "DINPro-CondBold"
        case textFont = ""
    }
    
    // Colors
    public enum Colors : Int {
        case grayLight = 0xA6A6A6
        func color() -> UIColor {
            return UIColorFromRGB(rgb: UInt(self.rawValue))
        }
    }
}
