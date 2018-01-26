
//
//  AsciiPackCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class AsciiPackCell: BasePackCell {
    
    static let identifier = "AsciiPackCell"
    
    @IBOutlet weak var emojiText: UILabel!
    
    override func configure(with item: EmojiPackViewModel) {
        super.configure(with: item)
        emojiText.text = item.inlineEmojis
    }
}
