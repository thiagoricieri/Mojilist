//
//  App.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation
import Saw

// MARK: - Production App
public struct ProductionAppConfigImpl: AppConfig {
    
	private(set) public var environment = Env.Host.production
	private(set) public var name: String = "Big Hug"
    private(set) public var restUrl: String = "https://"
    private(set) public var googleAnalytics: String = "UA-105801146-1"
}

// MARK: - Staging App
public struct StagingAppConfigImpl: AppConfig {

	private(set) public var environment = Env.Host.staging
	private(set) public var name: String = "Big Hug Staging"
    private(set) public var restUrl: String = "https://"
	private(set) public var googleAnalytics: String = "UA-64191503-5"
}
