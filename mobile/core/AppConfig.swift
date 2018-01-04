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
	default configuraiton to build
	and consume the application
*/
public protocol AppConfig {
	var environment: Env.Host { get }
	var name: String { get }
	var restUrl: String { get }
	var googleAnalytics: String { get }
    var fbAppId : String { get }
    var fbAppSecret : String { get }
    var twitterAppId : String { get }
    var twitterAppSecret : String { get }
}

// MARK: - Production App

public struct ProductionAppConfigImpl: AppConfig {
    
	private(set) public var environment = Env.Host.production
	private(set) public var name: String = "Big Hug"
    private(set) public var restUrl: String = "https://api.bighug.com.br"
    private(set) public var googleAnalytics: String = "UA-105801146-1"
    private(set) public var fbAppId: String = "1905419993028084"
    private(set) public var fbAppSecret: String = ""
    private(set) public var twitterAppId: String = "a4TUEueITqVhtnzMGFsRVcWt2"
    private(set) public var twitterAppSecret: String = "0gS8WL2ZYYBd3N5SrivUsHktemzDh2v0ss4uxDC90hOuxyif0A"
}

// MARK: - Staging App

public struct StagingAppConfigImpl: AppConfig {

	private(set) public var environment = Env.Host.staging
	private(set) public var name: String = "Big Hug Staging"
    private(set) public var restUrl: String = "https://api.dev.bighug.com.br"
	private(set) public var googleAnalytics: String = "UA-64191503-5"
    private(set) public var fbAppId: String = "1905419993028084"
    private(set) public var fbAppSecret: String = ""
    private(set) public var twitterAppId: String = "a4TUEueITqVhtnzMGFsRVcWt2"
    private(set) public var twitterAppSecret: String = "0gS8WL2ZYYBd3N5SrivUsHktemzDh2v0ss4uxDC90hOuxyif0A"
}
