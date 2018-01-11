//
//  AsciiEmojiCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class AsciiEmojiCell: BaseEmojiCell {
    
    static let identifier = "AsciiEmoji"
    
    @IBOutlet weak var emojiText: UILabel!
    
    override func configure(with emoji: REmoji) {
        super.configure(with: emoji)
        emojiText.text = emoji.name
    }
}
