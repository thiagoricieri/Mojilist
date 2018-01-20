//
//  BaseListCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class BaseListCell: BaseTableViewCell {
    
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var backgroundOverlay: UIView!
    @IBOutlet weak var separatorView: UIView!
    
    func configure(with item: REmojiList) {
        listName.text = item.name
    }
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        theme.primaryText(listName)
        theme.cellBackground(backgroundOverlay)
        theme.separator(separatorView)
    }
}
