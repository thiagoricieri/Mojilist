//
//  BaseTablePresenter.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

protocol BaseDataPresenter: BasePresenter {
    
    func loadSource()
    func downloadSource()
    
    func sourceCount() -> Int
    func item(at: Int) -> AnyObject
}
