//
//  ShareStudioViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 14/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class ShareSnippetView: UIView {
    
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var itemsContainer: UIView!
    @IBOutlet weak var creditsName: UILabel!
    @IBOutlet weak var creditsUrl: UILabel!
    
    func configure(with emojiList: REmojiList) {
        creditsName.text = "Share.Credits1".localized
        creditsUrl.text = "Share.Credits2".localized
        listName.text = emojiList.name
    }
}
