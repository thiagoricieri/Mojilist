//
//  AsciiListCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class AsciiListCell: BaseListCell {
    
    static let identifier = "ListCell"
    static let cellHeight = CGFloat(100)
    
    @IBOutlet weak var emojiText: UILabel!
    
    override func configure(with item: REmojiList) {
        super.configure(with: item)
        
        let maxEmojis = 7
        let allEmojis = item.emojis.count > maxEmojis ?
            item.emojis[0...maxEmojis].map { $0 } :
            item.emojis.map { $0 }
        
        var emojiString = ""
        for emoji in allEmojis {
            emojiString = emojiString + " " + emoji.name
        }
        
        emojiText.text = emojiString
    }
}
