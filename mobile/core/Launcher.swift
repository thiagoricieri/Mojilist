//
//  Launcher.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Firebase
import Saw

class Launcher: BaseLauncher {
    
    func setDefaultPack() -> Self {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: Env.App.defaultPack) == nil {
            defaults.set("things", forKey: Env.App.defaultPack)
        }
        return self
    }
    
    func includeStandardPack() -> Self {
        let realm = try! Realm()
        let query = realm.objects(REmojiPack.self).filter("ascii = true")
        
        guard query.count < 1 else {
            print("Standard pack is already included")
            return self
        }
        
        try! realm.write {
            [
                (
                    name: "Pack.EmojiThings",
                    emojis: thingsEmoji(),
                    slug: "things"
                ), (
                    name: "Pack.AllEmojis",
                    emojis: allEmojis(),
                    slug: "all"
                )
            ].forEach { emojiPack in
                let pack = REmojiPack()
                pack.name = emojiPack.name
                pack.ascii = true
                pack.slug = emojiPack.slug
                pack.url = ""
                
                for ec in emojiPack.emojis {
                    let e = REmojiPackItem()
                    e.name = String(ec)
                    e.pack = pack.slug
                    pack.emojis.append(e)
                }
                
                realm.add(pack)
            }
        }
        
        return self
    }
}
