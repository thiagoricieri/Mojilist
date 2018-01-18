//
//  ChangeThemePresenter.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 18/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

protocol ChangeThemePresenter: BaseDataPresenter {
    func visual(at: Int) -> Visuals
}

class ChangeThemePresenterImpl: ChangeThemePresenter {
    
    var view: ChangeThemeView!
    var source = [Visuals]()
    
    init(view: ChangeThemeView) {
        self.view = view
    }
    
    func loadSource() {
        source = Theme.available
    }
    
    func downloadSource() {
        // TODO
    }
    
    func sourceCount() -> Int {
        return source.count
    }
    
    func item(at: Int) -> AnyObject {
        return "" as AnyObject
    }
    
    func visual(at: Int) -> Visuals {
        return source[at]
    }
    
    // MARK: - Base Presenter
    func unload() {
        self.view = nil
    }
}
