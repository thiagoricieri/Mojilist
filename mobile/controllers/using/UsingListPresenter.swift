//
//  UsingListPresenter.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 12/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

protocol UsingListPresenter: BaseDataPresenter {
    
    var source: List<REmoji>! { get set }
    
    func toggleEmoji(at: Int)
    func resetCheckedEmojis()
    
    func deleteList(list: REmojiList)
    func shareList(list: REmojiList)
}

class UsingListPresenterImpl: UsingListPresenter {
    
    var view: UsingListView!
    var source: List<REmoji>!
    
    init(view: UsingListView) {
        self.view = view
    }
    
    // MARK: - Data Presenter
    func loadSource() {
        // None
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
    
    func toggleEmoji(at: Int) {
        let emoji = item(at: at) as! REmoji
        let realm = view.provideRealm()
        try! realm.write {
            emoji.checked = !emoji.checked
        }
    }
    
    func resetCheckedEmojis() {
        let checkedEmojis = source.filter("checked = true")
        let realm = view.provideRealm()
        try! realm.write {
            checkedEmojis.setValue(false, forKey: "checked")
        }
    }
    
    func deleteList(list: REmojiList) {
        let realm = view.provideRealm()
        try! realm.write {
            realm.delete(list)
        }
        view.listDeleted()
    }
    
    func shareList(list: REmojiList) {
        view.shareList()
    }
    
    // MARK: - Base Presenter
    func unload() {
        self.view = nil
    }
}
