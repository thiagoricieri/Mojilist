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

public class Launcher {
    
    // Vars
    private var launchParams: LaunchParams?
    private var provideCredentials = false
    private var app: App!
    
    // Weak references
    private weak var window: UIWindow?
    
    public func startWith(app usingApp: App) {
        app = usingApp
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    
    // MARK: - CHAINED CALLS
    
    // MARK: - UI
    
    public func setWindow(_ window: UIWindow?) -> Self {
        self.window = window
        return self
    }
    
    public func initialViewController(vc: UIViewController) -> Self {
        window?.rootViewController = vc
        return self
    }
    
    // MARK: - Configurable options
    
    public func shouldProvideCredentials(_ requirement: Bool) -> Self {
        provideCredentials = requirement
        return self
    }
    
    // MARK: - Deeplink
    
    public func setLaunchOptions(_ launchOptions: LaunchParams?) -> Self {
        self.launchParams = launchOptions
        return self
    }
    
    // MARK: - Migrate Realm
    
    public func migrateRealm() -> Self {
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        return self
    }
    
    public func includeStandardPack() -> Self {
        let realm = try! Realm()
        let query = realm.objects(REmojiPack.self).filter("ascii = true")
        guard query.count < 1 else {
            print("Standard pack is already included")
            return self
        }
        
        try! realm.write {
            let pack = REmojiPack()
            pack.name = "Pack.EmojiThings".localized
            pack.ascii = true
            pack.url = ""
            
            let emojis = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥥🥝🍅🍆🥑🥦🥒🌶🌽🥕🥔🍠🥐🍞🥖🥨🧀🥚🥞🥓🥩🍗🍖🌭🍔🍟🍕🥪🥙🌮🌯🥗🥘🥫🍝🍜🍲🍛🍣🍱🥟🍤🍙🍚🍘🍥🥠🍢🍡🍧🍨🍦🥧🍰🎂🍮🍭🍬🍫🍿🍩🍪🌰🥜🍯🥛☕️🍵🥤🍶🍺🍷🥃🍸🍹🥂🍾🍴🥣💧☂️🔥🎄🌲🌹🌻🌸🍄🍁🦀🐠🦑🐙🐟🐌👔👖👚👕👢👗👙🧦🧤🧣🎩🧢🎒👛🌂👞👟👡👠👓🕶💄👀👅⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🏒🏑🏏🎣🥊⛸🛷🎿🎫🎟🎭🎤🎧🎹🥁🎷🎺🎸🎻🎲🎯🎳🎮🛴🛵🚲🚗🚕🚙🏍✈️🗺⛱🏝⌚️📱💻⌨️🖥🖱🖨🕹📷📹📞☎️⏰🔦🕯🗑💵💶💴💷💎🔧🔨🔪🔩⚙️💊🛍🎁🖼🎈✉️📁🗞📔📎📌✂️🖊🖌✏️🖍".map { return $0 }
            
            for ec in emojis {
                let e = REmojiPackItem()
                e.name = String(ec)
                pack.emojis.append(e)
            }
            
            print("Added \(pack.emojis.count) emojis to \(pack.name) pack")
            realm.add(pack)
        }
        
        return self
    }
    
    // MARK: - Third-Party Integrations
    
    public func setFacebook() -> Self {
        // TODO: Add credentials
        return self
    }
    
    public func setFabric() -> Self {
        // TODO: Add credentials
        return self
    }
    
    public func setTwitter() -> Self {
        // TODO: Add credentials
        return self
    }
}
