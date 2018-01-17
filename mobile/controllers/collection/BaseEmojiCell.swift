//
//  BaseEmojiCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import Spring

class BaseEmojiCell: UICollectionViewCell {

    @IBOutlet weak var protectionBackground: UIView!
    @IBOutlet weak var springView: SpringView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        protectionBackground.clipsToBounds = true
        protectionBackground.layer.cornerRadius = protectionBackground.bounds.width/2
    }
    
    func applyTheme(_ theme: Theme) {
        theme.darkBackground(protectionBackground)
    }
    
    func configure(with emoji: REmojiPackItem) { }
    func configure(with emoji: REmoji) { }
    func uncheckEmoji() {  }
}
