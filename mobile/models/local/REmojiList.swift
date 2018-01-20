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

class EmojiListViewModel: BaseViewModel {
    
    private var model: REmojiList!
    
    var pendingName: String?
    
    var name: String! {
        return model.name
    }
    var dateCreated: Date? {
        return model.dateCreated
    }
    var timesUsed: Int! {
        return model.timesUsed
    }
    var items: [EmojiViewModel]! {
        return model.emojis.map { EmojiViewModel(with: $0) }
    }
    var checkedEmojis: [EmojiViewModel]! {
        return items.filter { $0.isChecked }
    }
    var firstEmojis: [EmojiViewModel]! {
        let maxEmojis = Env.App.maxEmojisPerRow
        return items.count > maxEmojis ?
            items[0...maxEmojis].map { $0 } : items
    }
    var inlineEmojis: String! {
        return firstEmojis.reduce("") { soFar, emoji -> String! in
            return soFar + " " + emoji.name
        }
    }
    
    init(named: String) {
        self.model = REmojiList()
        self.model.name = named
    }
    init(with model: REmojiList) {
        self.model = model
    }
    
    func uncheckCheckedEmojis() {
        let allChecked = model.emojis.filter("checked = true")
        try! realm.write {
            allChecked.setValue(false, forKey: "checked")
        }
    }
    
    func delete() {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func update(withPackItems itemModels: [EmojiPackItemViewModel]) {
        try! realm.write {
            model.name = pendingName!
            realm.delete(model.emojis)
            model.emojis.append(objectsIn: itemModels.map { item -> REmoji in
                return self.emojiModel(from: item)
            })
        }
    }
    
    func create(withPackItems itemModels: [EmojiPackItemViewModel]) {
        try! realm.write {
            model.timesUsed = 0
            model.dateCreated = Date()
            model.emojis.append(objectsIn: itemModels.map { item -> REmoji in
                return self.emojiModel(from: item)
            })
            realm.add(model)
        }
    }
    
    func emojiModel(from viewModel: EmojiPackItemViewModel) -> REmoji {
        let emoji = REmoji()
        emoji.name = viewModel.name
        emoji.checked = false
        emoji.imageUrl = viewModel.hasImage ? viewModel.imageUrl.absoluteString : ""
        emoji.pack = viewModel.pack
        return emoji
    }
}
