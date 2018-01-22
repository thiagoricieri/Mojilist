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

class Launcher {
    
    // Vars
    private var launchParams: LaunchParams?
    private var provideCredentials = false
    private var app: App!
    
    // Weak references
    private weak var window: UIWindow?
    
    func startWith(app usingApp: App) {
        app = usingApp
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    
    // MARK: - CHAINED CALLS
    
    // MARK: - UI
    
    func setWindow(_ window: UIWindow?) -> Self {
        self.window = window
        return self
    }
    
    func initialViewController(vc: UIViewController) -> Self {
        window?.rootViewController = vc
        return self
    }
    
    // MARK: - Configurable options
    
    func shouldProvideCredentials(_ requirement: Bool) -> Self {
        provideCredentials = requirement
        return self
    }
    
    func setDefaultPack() -> Self {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: Env.App.defaultPack) == nil {
            defaults.set("things", forKey: Env.App.defaultPack)
        }
        return self
    }
    
    // MARK: - Deeplink
    
    func setLaunchOptions(_ launchOptions: LaunchParams?) -> Self {
        self.launchParams = launchOptions
        return self
    }
    
    // MARK: - Migrate Realm
    
    func migrateRealm() -> Self {
        
        var config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 0) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        config.fileURL = config.fileURL!
            .deletingLastPathComponent()
            .appendingPathComponent("Mojilist.realm")
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
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
    
    // MARK: - Third-Party Integrations
    
    func setFirebase() -> Self {
        FirebaseApp.configure()
        return self
    }
    
    func setFacebook() -> Self {
        // TODO: Add credentials
        return self
    }
    
    func setFabric() -> Self {
        // TODO: Add credentials
        return self
    }
    
    func setTwitter() -> Self {
        // TODO: Add credentials
        return self
    }
}
