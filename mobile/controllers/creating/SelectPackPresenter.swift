//
//  SelectPackPresenter.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

protocol SelectPackPresenter: BaseDataPresenter {
}

class SelectPackPresenterImpl: SelectPackPresenter {
    
    var view: SelectPackView!
    var source: Results<REmojiPack>!
    
    init(view: SelectPackView) {
        self.view = view
    }
    
    // MARK: - Table Source
    func sourceCount() -> Int {
        return source.count
    }
    func item(at: Int) -> AnyObject {
        return source[at]
    }
    
    func loadSource() {
        let realm = view.provideRealm()
        source = realm.objects(REmojiPack.self).sorted(byKeyPath: "name")
    }
    
    func downloadSource() {
        // None
    }
    
    // MARK: - Base Presenter
    func unload() {
        self.view = nil
    }
}
