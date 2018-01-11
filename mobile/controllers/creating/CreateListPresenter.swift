//
//  CreateListPresenter.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

protocol CreateListPresenter: BasePresenter {
    
    func validateInput(listName: String?) -> Bool
}

class CreateListPresenterImpl: CreateListPresenter {
    
    var view: CreateListView!
    
    init(view: CreateListView) {
        self.view = view
    }
    
    func validateInput(listName: String?) -> Bool {
        return listName != nil && !listName!.isEmpty
    }
    
    // MARK: - Base Presenter
    func unload() {
        self.view = nil
    }
}
