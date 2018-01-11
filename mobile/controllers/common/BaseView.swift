//
//  BaseView.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

protocol BaseView {
    
    // Basic flow
    func instantiateDependencies()
    func setViewStyle()
    func prepareViewForUser()
    
    // Providing
    func provideApp() -> App
    func provideRealm() -> Realm
}
