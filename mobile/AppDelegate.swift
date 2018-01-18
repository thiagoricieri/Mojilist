//
//  AppDelegate.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/12/2017.
//  Copyright © 2017 Ghost Ship. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var launcher = Launcher()
    var window: UIWindow?
    var app: App = {
        #if DEBUG
            return StagingAppImpl()
        #else
            return ProductionAppImpl()
        #endif
    }()

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: LaunchParams?) -> Bool {
        
        launcher
            .setWindow(window)
            .shouldProvideCredentials(false)
            .setDefaultPack()
            .migrateRealm()
            .includeStandardPack()
            .setFabric()
            .setFacebook()
            .setTwitter()
            .setLaunchOptions(launchOptions)
            .startWith(app: app)
        
        return true
    }
    
    func standardEmojiPack() -> REmojiPack {
        return app.realm.objects(REmojiPack.self).filter("ascii = true").first!
    }
}
