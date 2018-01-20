//
//  ListsViewModel.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

class ListsViewModel: BaseDataViewModel {
    
    var source = [EmojiListViewModel]()
    
    override var itemsCount: Int! {
        return source.count
    }
    
    override func loadSource() {
        super.loadSource()
        
        source = realm
            .objects(REmojiList.self)
            .sorted(byKeyPath: "name")
            .map { EmojiListViewModel(with: $0) }
    }
    
    func item(at indexPath: IndexPath) -> EmojiListViewModel {
        return source[indexPath.row]
    }
}
