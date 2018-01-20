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

class EmojiViewModel: BaseViewModel {
    
    private var model: REmoji!
    
    static let uncheckedAlpha = CGFloat(0.2)
    static let checkedAlpha = CGFloat(1.0)
    
    var name: String! {
        return model.name
    }
    var imageUrl: URL! {
        return URL(string: model.imageUrl)!
    }
    var pack: String! {
        return model.pack
    }
    var isChecked: Bool! {
        return model.checked
    }
    var hasImage: Bool! {
        return !model.imageUrl.isEmpty
    }
    var alphaForCheckedStatus: CGFloat! {
        return isChecked ? EmojiViewModel.checkedAlpha : EmojiViewModel.uncheckedAlpha
    }
    
    init(with model: REmoji) {
        self.model = model
    }
    
    func change(checked: Bool) {
        try! realm.write {
            model.checked = checked
        }
    }
}
