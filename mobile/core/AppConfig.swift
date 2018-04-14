//
//  App.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation

/* 
	App protocol will represent
	default configuration to build
	and consume the application
*/
public protocol AppConfig {
	var environment: Env.Host { get }
	var name: String { get }
	var restUrl: String { get }
	var googleAnalytics: String { get }
}

// MARK: - Production App
public struct ProductionAppConfigImpl: AppConfig {
    
	private(set) public var environment = Env.Host.production
	private(set) public var name: String = "Emojilist"
    private(set) public var restUrl: String = "https://"
}

// MARK: - Staging App
public struct StagingAppConfigImpl: AppConfig {

	private(set) public var environment = Env.Host.staging
	private(set) public var name: String = "Emojilist Staging"
    private(set) public var restUrl: String = "https://"
}
