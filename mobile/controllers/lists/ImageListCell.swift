//
//  ImageListCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class ImageListCell: BaseListCell {
    
    static let identifier = "ImageListCell"
    static let cellHeight = CGFloat(100)
    
    @IBOutlet var emojiImages: [UIImageView]!
    
    override func configure(with item: EmojiListViewModel) {
        super.configure(with: item)
        
        emojiImages.forEach { imageView in
            let index = emojiImages.index(of: imageView)
            if  let i = index,
                item.firstEmojis.indices.contains(i) {
                
                let emoji = item.firstEmojis[i]
                imageView.sd_setImage(with: emoji.imageUrl)
            }
            else {
                imageView.image = nil
            }
        }
    }
}
