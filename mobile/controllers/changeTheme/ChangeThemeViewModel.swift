//
//  ChangeThemeViewModel.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import Saw

class ChangeThemeViewModel: BaseDataViewModel {
    
    var source = [Visuals]()
    
    override var itemsCount: Int! {
        return source.count
    }
    
    override func loadSource() {
        super.loadSource()
        source = Theme.available
    }
    
    func item(at: Int) -> Visuals {
        return source[at]
    }
    
    func changeVisuals(_ newVisuals: Visuals) {
        app.changeVisuals(newVisuals)
    }
}
