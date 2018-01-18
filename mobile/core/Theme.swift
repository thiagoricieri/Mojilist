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
        BasicVisual(), DarkVisual()
    ]
    
    let visuals: Visuals
    init(visuals: Visuals) {
        self.visuals = visuals
    }
    
    convenience init(visualString: String) {
        let visual: Visuals!
        switch visualString {
            case DarkVisual().identifier: visual = DarkVisual()
            default: visual = BasicVisual()
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
    
    // MARK: - Specific
    
    func cellBackground(_ view: UIView) {
        if let c = visuals.cellBackground { view.backgroundColor = color(c) }
    }
    
    func separator(_ view: UIView) {
        if let c = visuals.separatorColor { view.backgroundColor = color(c) }
    }
    
    func badge(_ view: UIView) {
        view.backgroundColor = color(visuals.badgeColor)
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
        bar.tintColor = color(visuals.accentColor)
        bar.backgroundColor = color(visuals.backgroundColorDark)
        bar.isOpaque = !visuals.isTranslucent
        bar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: color(visuals.secondaryTextColor)
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
    var badgeColor: UInt { get }
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
    
    var identifier = "basic"
    
    var primaryColor = UInt(0xFFFFFF)
    var primaryColorDark = UInt(0xCCCCCC)
    var accentColor = UInt(0xFF0000)
    
    var backgroundColor = UInt(0xFFFFFF)
    var backgroundColorDark = UInt(0xF1F1F1)
    var primaryTextColor = UInt(0x000000)
    var secondaryTextColor = UInt(0xCCCCCC)
    
    var barStyle = UIBarStyle.default
    var statusBar = UIStatusBarStyle.default
    var isTranslucent = true
    
    var badgeColor = UInt(0xFF0000)
    var separatorColor: UInt?
    var cellBackground: UInt?
    var topFadeDecorationName = "fade-top"
    var bottomFadeDecorationName = "fade-bottom"
    var downArrowDecorationName = "down"
    var emptyBoxDecorationName = "empty"
    var indicatorDecorationName = "indicator"
}

// MARK: - Dark
struct DarkVisual: Visuals {
    
    var identifier = "dark"
    
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
    
    var badgeColor = UInt(0xFF0000)
    var separatorColor: UInt? = UInt(0x333333)
    var cellBackground: UInt? = UInt(0x111111)
    var topFadeDecorationName = "dark-fade-top"
    var bottomFadeDecorationName = "dark-fade-bottom"
    var downArrowDecorationName = "down-dark"
    var emptyBoxDecorationName = "empty-dark"
    var indicatorDecorationName = "indicator-dark"
}
