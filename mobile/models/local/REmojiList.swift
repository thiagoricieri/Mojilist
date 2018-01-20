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
    
    let emojis = List<REmoji>()
}

class EmojiListViewModel {
    
    private var model: REmojiList!
    
    var name: String! {
        return model.name
    }
    var dateCreated: Date? {
        return model.dateCreated
    }
    var timesUsed: Int! {
        return model.timesUsed
    }
    var items: List<REmoji>! {
        return model.emojis
    }
    
    init(with model: REmojiList) {
        self.model = model
    }
}
