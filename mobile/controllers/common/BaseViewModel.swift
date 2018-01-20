//
//  BaseViewModel.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

class BaseViewModel {
    
    // MARK: - Convenience Vars
    
    var appDelegate: AppDelegate! {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var app: App! {
        return appDelegate.app
    }
    var realm: Realm! {
        return app.realm
    }
    var theme: Theme! {
        return app.theme
    }
}
