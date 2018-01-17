//
//  ListCell.swift
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

class ImageListCell: BaseListCell {
    
    static let identifier = "ImageListCell"
    static let cellHeight = CGFloat(100)
    
    @IBOutlet var emojiImages: [UIImageView]!
    
    override func configure(with item: REmojiList) {
        super.configure(with: item)
        
        let maxEmojis = 7
        let allEmojis = item.emojis.count > maxEmojis ?
            item.emojis[0...maxEmojis].map { $0 } :
            item.emojis.map { $0 }
        
        emojiImages.forEach { imageView in
            let index = emojiImages.index(of: imageView)
            if let i = index, allEmojis.indices.contains(i) {
                let emoji = allEmojis[i]
                imageView.sd_setImage(with: URL(string: emoji.imageUrl))
            } else {
                imageView.image = nil
            }
        }
    }
}

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
