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
}

class SelectEmojisPresenterImpl: SelectEmojisPresenter {
    
    var view: SelectEmojisView!
    var listName: String!
    var source: Results<REmoji>!
    
    init(view: SelectEmojisView) {
        self.view = view
    }
    
    // MARK: - Data Presenter
    func loadSource() {
        let realm = view.provideRealm()
        source = realm.objects(REmoji.self).sorted(byKeyPath: "name")
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
