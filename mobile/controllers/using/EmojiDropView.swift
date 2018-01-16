//
//  EmojiDropView.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 13/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import Spring
import SDWebImage

class EmojiDropView: SpringView {
    
    @IBOutlet weak var emojiText: UILabel!
    @IBOutlet weak var emojiImage: UIImageView!
    @IBOutlet weak var protectedArea: UIView!
    
    override func awakeFromNib() {
        emojiText.adjustsFontSizeToFitWidth = true
        protectedArea.layer.cornerRadius = protectedArea.bounds.width/2
        protectedArea.backgroundColor = UIColorFromRGB(rgb: 0xF1F1F1)
        //protectedArea.layer.shadowColor = UIColorFromRGB(rgb: 0x000000).cgColor
        //protectedArea.layer.shadowRadius = 3
        //protectedArea.layer.shadowOpacity = 0.2
        //protectedArea.layer.shadowOffset = CGSize(width: 0, height: 6)
    }
    
    func configure(with emoji: REmojiPackItem) {
        if emoji.imageUrl.isEmpty {
            emojiImage.isHidden = true
            emojiText.isHidden = false
            emojiText.text = emoji.name
        } else {
            emojiImage.isHidden = false
            emojiText.isHidden = true
            emojiImage.sd_setImage(with: URL(string: emoji.imageUrl)!)
        }
    }
    
    func configure(with emoji: REmoji) {
        if emoji.imageUrl.isEmpty {
            emojiImage.isHidden = true
            emojiText.isHidden = false
            emojiText.text = emoji.name
        } else {
            emojiImage.isHidden = false
            emojiText.isHidden = true
            emojiImage.sd_setImage(with: URL(string: emoji.imageUrl)!)
        }
    }
    
    func resize(square itemSize: Int) {
        protectedArea.layer.cornerRadius = CGFloat(itemSize/2)
        emojiText.font = UIFont(name: emojiText.font.fontName, size: CGFloat(itemSize) * 0.6)
    }
    
    func dropAnimation(toX: CGFloat, toY: CGFloat) {
        x = toX
        animateToNext {
            self.y = toY
            self.animateTo()
            self.animateToNext {
                self.removeFromSuperview()
            }
        }
    }
}
