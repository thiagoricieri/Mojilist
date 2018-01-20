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
    
    @objc dynamic var slug = ""
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var ascii = false
    
    let emojis = List<REmojiPackItem>()
}

class EmojiPackViewModel: BaseViewModel {
    
    private var model: REmojiPack!
    
    var name: String! {
        return model.name
    }
    var slug: String! {
        return model.slug
    }
    var url: String! {
        return model.url
    }
    var isTextual: Bool! {
        return model.ascii
    }
    var items: [EmojiPackItemViewModel]! {
        return model.emojis.map { EmojiPackItemViewModel(with: $0) }
    }
    var firstEmojis: [EmojiPackItemViewModel]! {
        let maxEmojis = Env.App.maxEmojisPerRow
        return items.count > maxEmojis ?
            items[0...maxEmojis].map { $0 } : items
    }
    var inlineEmojis: String! {
        return firstEmojis.reduce("") { soFar, emoji -> String! in
            return soFar + " " + emoji.name
        }
    }
    
    init(with model: REmojiPack) {
        self.model = model
    }
}
