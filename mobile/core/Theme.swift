//
//  Theme.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 13/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import Saw

class Theme: Saw.Theme {
    
    static let available: [Visuals] = [
        BasicVisual(), DarkVisual(), GreenyVisual(),
        BlueVisual(), DragVisual(), DraculaVisual(),
        CandyVisual()
    ]
    
    var visuals: Visuals
    
    init(visuals: Visuals) {
        self.visuals = visuals
    }
    
    convenience init(visualString: String) {
        var visual: Visuals = BasicVisual()
        for v in Theme.available {
            if v.identifier == visualString {
                visual = v
            }
        }
        self.init(visuals: visual)
    }
}

// MARK: - Dark
struct DarkVisual: Visuals {
    
    var identifier = "Theme.Dark"
    var icon: String? = "MojilistDark"
    
    var primaryColor = UInt(0x333333)
    var primaryColorDark = UInt(0x000000)
    var accentColor = UInt(0xFFFF00)
    
    var backgroundColor = UInt(0x000000)
    var backgroundColorDark = UInt(0x111111)
    var primaryTextColor = UInt(0xFFFFFF)
    var secondaryTextColor = UInt(0xF1F1F1)
    
    var barStyle = UIBarStyle.black
    var statusBar = UIStatusBarStyle.lightContent
    var isTranslucent = false
    
    var contrastColor = UInt(0xFF0000)
    var separatorColor: UInt? = UInt(0x333333)
    var cellBackground: UInt? = UInt(0x111111)
    var topFadeDecorationName = "dark-fade-top"
    var bottomFadeDecorationName = "dark-fade-bottom"
    var downArrowDecorationName = "down-dark"
    var emptyBoxDecorationName = "empty-dark"
    var indicatorDecorationName = "indicator-dark"
}

// MARK: - Dark
struct GreenyVisual: Visuals {
    
    var identifier = "Theme.Greeny"
    var icon: String? = "MojilistGreeny"
    
    var accentColor = UInt(0x00b3aa)
    var contrastColor = UInt(0xff7a03)
    
    var primaryColor = UInt(0xb3efec)
    var primaryColorDark = UInt(0xa7e5e2)
    
    var backgroundColor = UInt(0xb3efec)
    var backgroundColorDark = UInt(0x9ae7e3)
    
    var primaryTextColor = UInt(0x2a7975)
    var secondaryTextColor = UInt(0x50b4af)
    
    var separatorColor: UInt? = UInt(0x94dcd8)
    var cellBackground: UInt? = UInt(0xaaeae7)
    
    var barStyle = UIBarStyle.default
    var statusBar = UIStatusBarStyle.default
    var isTranslucent = false
    
    var topFadeDecorationName = "fade-top-green"
    var bottomFadeDecorationName = "fade-bottom-green"
    var downArrowDecorationName = "down"
    var emptyBoxDecorationName = "empty"
    var indicatorDecorationName = "indicator"
}

// MARK: - Dark
struct BlueVisual: Visuals {
    
    var identifier = "Theme.Blue"
    var icon: String? = "MojilistBlue"
    
    var accentColor = UInt(0xefe822)
    var contrastColor = UInt(0xef2266)
    
    var primaryColor = UInt(0x58c5e4)
    var primaryColorDark = UInt(0x6bcde9)
    
    var backgroundColor = UInt(0x58c5e4)
    var backgroundColorDark = UInt(0x6bcde9)
    
    var primaryTextColor = UInt(0x22748b)
    var secondaryTextColor = UInt(0x3d9db8)
    
    var separatorColor: UInt? = UInt(0x51bddc)
    var cellBackground: UInt? = UInt(0x6bcde9)
    
    var barStyle = UIBarStyle.default
    var statusBar = UIStatusBarStyle.default
    var isTranslucent = false
    
    var topFadeDecorationName = "fade-top-blue"
    var bottomFadeDecorationName = "fade-bottom-blue"
    var downArrowDecorationName = "down"
    var emptyBoxDecorationName = "empty"
    var indicatorDecorationName = "indicator"
}

// MARK: - Dark
struct DragVisual: Visuals {
    
    var identifier = "Theme.Drag"
    var icon: String? = "MojilistDrag"
    
    var accentColor = UInt(0xef2266)
    var contrastColor = UInt(0xefe822)
    
    var primaryColor = UInt(0xf86a99)
    var primaryColorDark = UInt(0x0e4ff2)
    
    var backgroundColor = UInt(0xf86a99)
    var backgroundColorDark = UInt(0xffc8da)
    
    var primaryTextColor = UInt(0x9f0c3d)
    var secondaryTextColor = UInt(0xffffff)
    
    var separatorColor: UInt? = UInt(0xe55a88)
    var cellBackground: UInt? = UInt(0xf897b7)
    
    var barStyle = UIBarStyle.default
    var statusBar = UIStatusBarStyle.lightContent
    var isTranslucent = false
    
    var topFadeDecorationName = "fade-top-drag"
    var bottomFadeDecorationName = "fade-bottom-drag"
    var downArrowDecorationName = "down-dark"
    var emptyBoxDecorationName = "empty-dark"
    var indicatorDecorationName = "indicator-dark"
}

// MARK: - Dark
struct DraculaVisual: Visuals {
    
    var identifier = "Theme.Dracula"
    var icon: String? = "MojilistDracula"
    
    var accentColor = UInt(0x11dc16)
    var contrastColor = UInt(0xce0404)
    
    var primaryColor = UInt(0x1e142a)
    var primaryColorDark = UInt(0x331e4c)
    
    var backgroundColor = UInt(0x1e142a)
    var backgroundColorDark = UInt(0x331e4c)
    
    var primaryTextColor = UInt(0xffffff)
    var secondaryTextColor = UInt(0x8147c6)
    
    var separatorColor: UInt? = UInt(0x180d26)
    var cellBackground: UInt? = UInt(0x241833)
    
    var barStyle = UIBarStyle.black
    var statusBar = UIStatusBarStyle.default
    var isTranslucent = false
    
    var topFadeDecorationName = "fade-top-dracula"
    var bottomFadeDecorationName = "fade-bottom-dracula"
    var downArrowDecorationName = "down-dark"
    var emptyBoxDecorationName = "empty-dark"
    var indicatorDecorationName = "indicator-dark"
}

// MARK: - Dark
struct CandyVisual: Visuals {
    
    var identifier = "Theme.Candy"
    var icon: String? = "MojilistCandy"
    
    var accentColor = UInt(0x1de3fb)
    var contrastColor = UInt(0xfb1dcf)
    
    var primaryColor = UInt(0xfffee8)
    var primaryColorDark = UInt(0xffe5fc)
    
    var backgroundColor = UInt(0xfffee8)
    var backgroundColorDark = UInt(0xffe5fc)
    
    var primaryTextColor = UInt(0x8c5185)
    var secondaryTextColor = UInt(0xa7a584)
    
    var separatorColor: UInt? = UInt(0xf6f4c2)
    var cellBackground: UInt? = UInt(0xe9feff)
    
    var barStyle = UIBarStyle.default
    var statusBar = UIStatusBarStyle.default
    var isTranslucent = false
    
    var topFadeDecorationName = "fade-top-candy"
    var bottomFadeDecorationName = "fade-bottom-candy"
    var downArrowDecorationName = "down"
    var emptyBoxDecorationName = "empty"
    var indicatorDecorationName = "indicator"
}
