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
}

class SelectEmojisPresenterImpl: SelectEmojisPresenter {
    
    var view: SelectEmojisView!
    var listName: String!
    var source: List<REmojiPackItem>!
    var pack: REmojiPack!
    
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
    
    // MARK: - Base Presenter
    func unload() {
        self.view = nil
    }
}
