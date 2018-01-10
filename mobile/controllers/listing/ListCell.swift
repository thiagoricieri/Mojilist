//
//  ListCell.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class ListCell: BaseTableViewCell {
    
    static let identifier = "ListCell"
    static let cellHeight = CGFloat(100)
    
    @IBOutlet weak var listName: UILabel!
    
    func configure(with item: REmojiList) {
        listName.text = item.name
    }
}
