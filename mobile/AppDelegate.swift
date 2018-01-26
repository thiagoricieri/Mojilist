//
//  AppDelegate.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/12/2017.
//  Copyright © 2017 Ghost Ship. All rights reserved.
//

import UIKit
import RealmSwift
import Saw

@UIApplicationMain
class AppDelegate: UIResponder, SawAppDelegate {

    var launcher = Launcher()
    var window: UIWindow?
    
    var app: App = {
        #if DEBUG
            return MojilistStagingAppImpl()
        #else
            return MojilistProductionAppImpl()
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
}
