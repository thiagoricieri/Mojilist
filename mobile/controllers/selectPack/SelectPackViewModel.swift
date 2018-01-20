//
//  SelectPackViewModel.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

class SelectPackViewModel: BaseDataViewModel {
    
    var source: [EmojiPackViewModel]!
    
    override var itemsCount: Int! {
        return source.count
    }
    
    override func loadSource() {
        super.loadSource()
        source = realm
            .objects(REmojiPack.self)
            .sorted(byKeyPath: "name")
            .map { EmojiPackViewModel(with: $0) }
    }
    
    func item(at indexPath: IndexPath) -> EmojiPackViewModel {
        return source[indexPath.row]
    }
    
    func trackChanged(toPack pack: EmojiPackViewModel) {
        Tracker.changedPack(packSlug: pack.slug)
    }
}
