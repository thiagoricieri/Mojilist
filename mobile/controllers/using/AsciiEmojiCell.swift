//
//  AsciiEmojiCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import Saw

class AsciiEmojiCell: BaseEmojiCell {
    
    static let identifier = "AsciiEmoji"
    
    @IBOutlet weak var emojiText: UILabel!
    
    override func configure(with emoji: EmojiPackItemViewModel) {
        super.configure(with: emoji)
        emojiText.text = emoji.name
    }
    
    override func configure(with emoji: EmojiViewModel) {
        super.configure(with: emoji)
        emojiText.text = emoji.name
        emojiText.alpha = emoji.alphaForCheckedStatus
    }
    
    override func uncheckEmoji() {
        emojiText.alpha = CGFloat(EmojiViewModel.uncheckedAlpha)
    }
}
