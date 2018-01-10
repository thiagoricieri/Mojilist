//
//  EmojiList.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

class REmojiList: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var dateCreated: Date? = nil
    @objc dynamic var timesUsed = 0
    
    let emojis = List<REmojiItem>()
}
