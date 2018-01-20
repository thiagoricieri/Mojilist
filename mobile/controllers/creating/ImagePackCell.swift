//
//  ImagePackCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class ImagePackCell: BasePackCell {
    
    static let identifier = "ImagePackCell"
    
    @IBOutlet var emojiImages: [UIImageView]!
    
    override func configure(with item: REmojiPack) {
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
