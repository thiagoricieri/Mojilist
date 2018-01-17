//
//  File.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewCell: UITableViewCell {
    
    func applyTheme(_ theme: Theme) {
        theme.background(self)
        theme.background(self.contentView)
        
        if let v = self.backgroundView { theme.background(v) }
        if let v = self.selectedBackgroundView { theme.darkBackground(v) }
    }
}
