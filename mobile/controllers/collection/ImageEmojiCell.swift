//
//  ImageEmojiCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ImageEmojiCell: BaseEmojiCell {
    
    static let identifier = "ImageEmoji"
    
    @IBOutlet weak var emojiImage: UIImageView!
    
    override func configure(with emoji: REmoji) {
        super.configure(with: emoji)
        emojiImage.sd_setImage(with: URL(string: emoji.imageUrl))
    }
}
