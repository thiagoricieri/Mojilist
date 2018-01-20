//
//  SelectEmojisViewModel.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

class SelectEmojisViewModel: BaseDataViewModel {
    
    private var listViewModel: EmojiListViewModel!
    private var selectedItems = [EmojiPackItemViewModel]()
    
    var source: EmojiPackViewModel!
    
    override var itemsCount: Int! {
        return source.items.count
    }
    var listName: String! {
        return listViewModel.name
    }
    var selectedCount: Int! {
        return selectedItems.count
    }
    var selectedCountText: String! {
        return String(selectedCount)
    }
    var localizedPackName: String! {
        return "SelectEmojis.SelectPack".localized + " \(source.name!)"
    }
    
    init(listViewModel: EmojiListViewModel) {
        super.init()
        self.listViewModel = listViewModel
        
        let defaults = UserDefaults.standard
        if let pack = defaults.string(forKey: Env.App.defaultPack) {
            let predicate = NSPredicate(format: "slug = %@", pack)
            let packs = realm.objects(REmojiPack.self).filter(predicate)
            if packs.count > 0 {
                source = EmojiPackViewModel(with: packs.first!)
            }
        } else {
            source = app.standardEmojiPack()
        }
    }
    
    func item(at indexPath: IndexPath) -> EmojiPackItemViewModel {
        return source.items[indexPath.row]
    }
    
    // MARK: - Handle Selection
    
    func item(selectedAt indexPath: IndexPath) -> EmojiPackItemViewModel {
        return selectedItems[indexPath.row]
    }
    
    func select(emojiAt indexPath: IndexPath) {
        let emoji = item(at: indexPath)
        selectedItems.insert(emoji, at: 0)
    }
    
    func createList() {
        listViewModel.create(withPackItems: selectedItems)
        Tracker.newList(itemsCount: selectedItems.count)
    }
    
    func remove(emojiAt indexPath: IndexPath) {
        selectedItems.remove(at: indexPath.row)
    }
    
    func clearList() {
        selectedItems = []
    }
}
