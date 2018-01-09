//
//  Launcher.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

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
