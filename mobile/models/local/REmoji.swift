//
//  EmojiItem.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

class REmoji: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var pack = ""
    @objc dynamic var checked = false 
}

class EmojiViewModel {
    
    private var model: REmoji!
    
    var name: String! {
        return model.name
    }
    var imageUrl: String! {
        return model.imageUrl
    }
    var pack: String! {
        return model.pack
    }
    var isChecked: Bool! {
        return model.checked
    }
    
    init(with model: REmoji) {
        self.model = model
    }
}
