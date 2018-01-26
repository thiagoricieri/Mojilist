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
import Saw

public class EmojiDropView: SpringView {
    
    @IBOutlet public weak var emojiText: UILabel!
    @IBOutlet public weak var emojiImage: UIImageView!
    @IBOutlet public weak var protectedArea: UIView!
    
    override public func awakeFromNib() {
        emojiText.adjustsFontSizeToFitWidth = true
        protectedArea.layer.cornerRadius = protectedArea.bounds.width/2
        protectedArea.backgroundColor = UIColorFromRGB(rgb: 0xF1F1F1)
        //protectedArea.layer.shadowColor = UIColorFromRGB(rgb: 0x000000).cgColor
        //protectedArea.layer.shadowRadius = 3
        //protectedArea.layer.shadowOpacity = 0.2
        //protectedArea.layer.shadowOffset = CGSize(width: 0, height: 6)
    }
    
    public func applyTheme(_ theme: Theme) {
        theme.darkBackground(protectedArea)
        theme.primaryText(emojiText)
    }
    
    public func configure(with emoji: EmojiPackItemViewModel) {
        if !emoji.hasImage {
            emojiImage.isHidden = true
            emojiText.isHidden = false
            emojiText.text = emoji.name
        } else {
            emojiImage.isHidden = false
            emojiText.isHidden = true
            emojiImage.sd_setImage(with: emoji.imageUrl)
        }
    }
    
    public func configure(with emoji: EmojiViewModel) {
        if !emoji.hasImage {
            emojiImage.isHidden = true
            emojiText.isHidden = false
            emojiText.text = emoji.name
        } else {
            emojiImage.isHidden = false
            emojiText.isHidden = true
            emojiImage.sd_setImage(with: emoji.imageUrl)
        }
    }
    
    public func resize(square itemSize: Int) {
        protectedArea.layer.cornerRadius = CGFloat(itemSize/2)
        emojiText.font = UIFont(name: emojiText.font.fontName, size: CGFloat(itemSize) * 0.6)
    }
    
    public func dropAnimation(toX: CGFloat, toY: CGFloat) {
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

