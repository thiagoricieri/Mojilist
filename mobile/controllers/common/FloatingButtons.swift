//
//  FloatButton.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class PrimaryFloatingButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 14
        self.layer.shadowColor = UIColorFromRGB(rgb: 0x000000).cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
    }
}

class SecondaryFloatingButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColorFromRGB(rgb: 0x000000).cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
    }
}
