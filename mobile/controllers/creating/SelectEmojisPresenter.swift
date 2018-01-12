//
//  SelectEmojisPresenter.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

protocol SelectEmojisPresenter: BaseDataPresenter {
    
    var pack: REmojiPack! { get set }
    
    func selectEmoji(at: Int)
    func clearList()
    func createList(with name: String)
}

class SelectEmojisPresenterImpl: SelectEmojisPresenter {
    
    var view: SelectEmojisView!
    var source: List<REmojiPackItem>!
    var pack: REmojiPack!
    var emojisToList = [REmojiPackItem: Int]()
    
    init(view: SelectEmojisView) {
        self.view = view
    }
    
    // MARK: - Data Presenter
    func loadSource() {
        source = pack.emojis
    }
    
    func downloadSource() {
        // None
    }
    
    func sourceCount() -> Int {
        return source.count
    }
    
    func item(at: Int) -> AnyObject {
        return source[at]
    }
    
    func selectEmoji(at: Int) {
        let emoji = item(at: at) as! REmojiPackItem
        
        if let count = emojisToList[emoji] {
            emojisToList[emoji] = count + 1
        } else {
            emojisToList[emoji] = 1
        }
        
        view.updateEmojiInListCount(to: emojisToList.count)
    }
    
    func clearList() {
        emojisToList = [:]
        view.updateEmojiInListCount(to: emojisToList.count)
    }
    
    func createList(with name: String) {
        let realm = view.provideRealm()
        
        try! realm.write {
            let list = REmojiList()
            list.name = name
            list.timesUsed = 0
            list.dateCreated = Date()
            list.emojis.append(objectsIn: emojisToList.map { item, _ -> REmoji in
                let emoji = REmoji()
                emoji.name = item.name
                emoji.checked = false
                emoji.imageUrl = item.imageUrl
                return emoji
            })
            realm.add(list)
        }
        
        view.listCreated()
    }
    
    // MARK: - Base Presenter
    func unload() {
        self.view = nil
    }
}
