//
//  BaseEmojiCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class BaseEmojiCell: UICollectionViewCell {

    @IBOutlet weak var protectionBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        protectionBackground.clipsToBounds = true
        protectionBackground.layer.cornerRadius = protectionBackground.bounds.width/2
    }
    
    func configure(with emoji: REmojiPackItem) {
    }
}
