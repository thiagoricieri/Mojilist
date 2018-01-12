//
//  REmojiPack.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

class REmojiPack: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var ascii = false
    
    let emojis = List<REmojiPackItem>()
}
