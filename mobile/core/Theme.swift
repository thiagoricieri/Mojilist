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
    
    func identifier() -> String {
        return visuals.identifier
    }
    
    // MARK: - View Styling
    func background(_ view: UIView) {
        view.backgroundColor = color(visuals.backgroundColor)
    }
    
    func darkBackground(_ view: UIView) {
        view.backgroundColor = color(visuals.backgroundColorDark)
    }
    
    func background(_ navigation: UINavigationBar) {
        navigation.backgroundColor = color(visuals.backgroundColorDark)
    }
    
    func accent(_ view: UIView) {
        view.tintColor = color(visuals.accentColor)
    }
    
    func tintAccent(_ view: UIView) {
        view.tintColor = color(visuals.accentColor)
    }
    
    func background(_ view: UITableViewCell) {
        view.backgroundView?.backgroundColor = color(visuals.backgroundColor)
        view.backgroundColor = color(visuals.backgroundColor)
        view.contentView.backgroundColor = color(visuals.backgroundColor)
    }
    
    func darkBackground(_ view: UITableViewCell) {
        view.backgroundView?.backgroundColor = color(visuals.backgroundColorDark)
        view.backgroundColor = color(visuals.backgroundColorDark)
        view.contentView.backgroundColor = color(visuals.backgroundColorDark)
    }

    // MARK: - Texts
    
    func textAccent(_ view: UITextField) {
        view.textColor = color(visuals.accentColor)
    }
    
    func textAccent(_ view: UITextView) {
        view.textColor = color(visuals.accentColor)
    }
    
    func textAccent(_ view: UILabel) {
        view.textColor = color(visuals.accentColor)
    }
    
    func primaryText(_ view: UITextField) {
        view.textColor = color(visuals.primaryTextColor)
    }
    
    func primaryText(_ view: UITextView) {
        view.textColor = color(visuals.primaryTextColor)
    }
    
    func primaryText(_ view: UILabel) {
        view.textColor = color(visuals.primaryTextColor)
    }
    
    func secondaryText(_ view: UITextField) {
        view.textColor = color(visuals.secondaryTextColor)
    }
    
    func secondaryText(_ view: UITextView) {
        view.textColor = color(visuals.secondaryTextColor)
    }
    
    func secondaryText(_ view: UILabel) {
        view.textColor = color(visuals.secondaryTextColor)
    }
    
    func primaryColor(_ view: UITextField) {
        view.textColor = color(visuals.primaryColor)
    }
    
    func primaryColor(_ view: UITextView) {
        view.textColor = color(visuals.primaryColor)
    }
    
    func primaryColor(_ view: UILabel) {
        view.textColor = color(visuals.primaryColor)
    }
    
    func contrastColor(_ view: UITextField) {
        view.textColor = color(visuals.contrastColor)
    }
    
    func contrastColor(_ view: UITextView) {
        view.textColor = color(visuals.contrastColor)
    }
    
    func contrastColor(_ view: UILabel) {
        view.textColor = color(visuals.contrastColor)
    }
    
    // MARK: - Specific
    
    func cellBackground(_ view: UIView) {
        if let c = visuals.cellBackground { view.backgroundColor = color(c) }
    }
    
    func cellBackground(_ view: UITableViewCell) {
        if let c = visuals.cellBackground {
            view.backgroundColor = color(c)
            view.backgroundView?.backgroundColor = color(c)
            view.contentView.backgroundColor = color(c)
        }
    }
    
    func separator(_ view: UIView) {
        if let c = visuals.separatorColor { view.backgroundColor = color(c) }
    }
    
    func badge(_ view: UIView) {
        view.backgroundColor = color(visuals.contrastColor)
    }
    
    // MARK: - Buttons
    
    func actionButton(_ button: UIButton) {
        button.backgroundColor = color(visuals.accentColor)
        button.setTitleColor(color(visuals.primaryColor), for: .normal)
        button.setTitleColor(color(visuals.primaryColorDark), for: .disabled)
    }
    
    func secondaryButton(_ button: UIButton) {
        button.backgroundColor = color(visuals.primaryColor)
        button.setTitleColor(color(visuals.primaryTextColor), for: .normal)
        button.setTitleColor(color(visuals.secondaryTextColor), for: .disabled)
        button.tintColor = color(visuals.primaryTextColor)
    }
    
    // MARK: - Images
    
    func topDecoration() -> String {
        return visuals.topFadeDecorationName
    }
    
    func bottomDecoration() -> String {
        return visuals.bottomFadeDecorationName
    }
    
    func downArrowDecoration() -> String {
        return visuals.downArrowDecorationName
    }
    
    func emptyBoxDecoration() -> String {
        return visuals.emptyBoxDecorationName
    }
    
    func indicatorDecoration() -> String {
        return visuals.indicatorDecorationName
    }
    
    // MARK: - UINavigation Bar
    
    func styleNavigationBar(_ bar: UINavigationBar) {
        bar.barStyle = visuals.barStyle
        bar.barTintColor = color(visuals.backgroundColorDark)
        bar.tintColor = color(visuals.accentColor)
        bar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        bar.isTranslucent = visuals.isTranslucent
        bar.backgroundColor = color(visuals.backgroundColorDark)
        bar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: color(visuals.primaryTextColor)
        ]
    }
    
    func statusBarStyle() -> UIStatusBarStyle {
        return visuals.statusBar
    }
    
    // MARK: - Helpers
    func color(_ color: UInt) -> UIColor {
        return UIColorFromRGB(rgb: color)
    }
}

// MARK: - Visuals
protocol Visuals {
    
    var identifier: String { get }
    var primaryColor: UInt { get }
    var primaryColorDark: UInt { get }
    var accentColor: UInt { get }
    
    var backgroundColor: UInt { get }
    var backgroundColorDark: UInt { get }
    var primaryTextColor: UInt { get }
    var secondaryTextColor: UInt { get }
    
    // Non-colors
    var barStyle: UIBarStyle { get }
    var statusBar: UIStatusBarStyle { get }
    var isTranslucent: Bool { get }
    
    // Specific from app layout
    var contrastColor: UInt { get }
    var separatorColor: UInt? { get }
    var cellBackground: UInt? { get }
    var topFadeDecorationName: String { get }
    var bottomFadeDecorationName: String { get }
    var downArrowDecorationName: String { get }
    var emptyBoxDecorationName: String { get }
    var indicatorDecorationName: String { get }
}

// MARK: - Basic
struct BasicVisual: Visuals {
    
    var identifier = "Theme.Basic"
    
    var primaryColor = UInt(0xFFFFFF)
    var primaryColorDark = UInt(0xDDDDDD)
    var accentColor = UInt(0xED4962)
    
    var backgroundColor = UInt(0xFFFFFF)
    var backgroundColorDark = UInt(0xF1F1F1)
    var primaryTextColor = UInt(0x000000)
    var secondaryTextColor = UInt(0xCCCCCC)
    
    var barStyle = UIBarStyle.default
    var statusBar = UIStatusBarStyle.default
    var isTranslucent = false
    
    var contrastColor = UInt(0x5ACDE3)
    var separatorColor: UInt? = UInt(0xDDDDDD)
    var cellBackground: UInt? = UInt(0xFDFDFD)
    var topFadeDecorationName = "fade-top"
    var bottomFadeDecorationName = "fade-bottom"
    var downArrowDecorationName = "down"
    var emptyBoxDecorationName = "empty"
    var indicatorDecorationName = "indicator"
}

// MARK: - Dark
struct DarkVisual: Visuals {
    
    var identifier = "Theme.Dark"
    
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
