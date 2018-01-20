//
//  REmojiPackItem.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

class REmojiPackItem: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var pack = ""
}

class EmojiPackItemViewModel: BaseViewModel {
    
    private var model: REmojiPackItem!
    
    var name: String! {
        return model.name
    }
    var pack: String! {
        return model.pack
    }
    var imageUrl: URL! {
        return URL(string: model.imageUrl)!
    }
    var hasImage: Bool! {
        return !model.imageUrl.isEmpty
    }
    
    init(with model: REmojiPackItem) {
        self.model = model
    }
}
