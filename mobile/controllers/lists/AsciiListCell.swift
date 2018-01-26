//
//  AsciiListCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import Saw

class AsciiListCell: BaseListCell {
    
    static let identifier = "ListCell"
    static let cellHeight = CGFloat(100)
    
    @IBOutlet weak var emojiText: UILabel!
    
    override func configure(with item: EmojiListViewModel) {
        super.configure(with: item)
        emojiText.text = item.inlineEmojis
    }
}
