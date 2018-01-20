//
//  UsingListViewModel.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

class UsingListViewModel: BaseDataViewModel {
    
    var source: EmojiListViewModel!
    var name: String! {
        return source.name
    }
    
    override var itemsCount: Int! {
        return source.items.count
    }
    
    init(list: EmojiListViewModel) {
        self.source = list
    }
    
    func item(at indexPath: IndexPath) -> EmojiViewModel {
        return source.items[indexPath.row]
    }
    
    func toggleEmoji(at indexPath: IndexPath) {
        let emoji = item(at: indexPath)
        emoji.change(checked: !emoji.isChecked)
    }
    
    func reuseList() {
        Tracker.reusedList(itemsCount: itemsCount)
        source.uncheckCheckedEmojis()
    }
    
    func deleteList() {
        Tracker.deleteList(itemsCount: itemsCount)
        source.delete()
    }
    
    func trackSharing() {
        Tracker.shareImage()
    }
    
    func trackCompletedList() {
        Tracker.completeList(
            itemsCount: itemsCount,
            itemsUsed: source.checkedEmojis.count)
    }
}
