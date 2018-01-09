//
//  App.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation
import DateToolsSwift

public protocol App {
	
	var config: AppConfig { get }
	var documentPath: String { get }
	
	var humamFormatter: DateFormatter { get }
	var posixFormatter: DateFormatter { get }
    var sqlFormatter: DateFormatter { get }
	var currencyFormatter: NumberFormatter { get }
    
    func convertToDate(fromSql: String) -> Date?
    func convertToDate(fromSimpleSql: String) -> Date?
    func dateToSql(fromHuman: String) -> String
    func dateToSimpleSql(fromHuman: String) -> String
    func dateToHuman(fromSql: String) -> String
    func dateToHuman(from: String, toFormat: String) -> String
    func dateToHuman(fromSimpleSql: String) -> String
}

// MARK: - Production App
open class ProductionAppImpl: App {
	
	fileprivate(set) public var config: AppConfig
	fileprivate(set) public var documentPath:String
	
	fileprivate(set) public lazy var humamFormatter: DateFormatter = self.initHumanFormatter()
	fileprivate(set) public lazy var posixFormatter: DateFormatter = self.initPosixFormatter()
    fileprivate(set) public lazy var sqlFormatter: DateFormatter = self.initSqlFormatter()
    fileprivate(set) public lazy var simpleSqlFormatter: DateFormatter = self.initSimpleSqlFormatter()
	fileprivate(set) public lazy var currencyFormatter: NumberFormatter = self.initCurrencyFormatter()
	
	public init() {
		self.config = ProductionAppConfigImpl()
		self.documentPath = ""
	}
	
	// Init formatters
	fileprivate func initHumanFormatter() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
	}
    
	fileprivate func initPosixFormatter() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyyMMdd'T'HHmmssZZZ"
        df.locale = Locale(identifier:"en_US_POSIX")
        return df
	}
    
	fileprivate func initSqlFormatter() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
	}
    
    fileprivate func initSimpleSqlFormatter() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
	fileprivate func initCurrencyFormatter() -> NumberFormatter {
		let df = NumberFormatter()
		df.numberStyle = .currency
		df.locale = Locale(identifier: "pt_BR")
		return df
	}
    
    public func dateToSql(fromHuman: String) -> String {
        let date = humamFormatter.date(from: fromHuman)
        return sqlFormatter.string(from: date!)
    }
    
    public func dateToSimpleSql(fromHuman: String) -> String {
        let date = humamFormatter.date(from: fromHuman)
        return simpleSqlFormatter.string(from: date!)
    }
    
    public func dateToHuman(fromSql: String) -> String {
        let date = sqlFormatter.date(from: fromSql)
        return humamFormatter.string(from: date!)
    }
    
    public func convertToDate(fromSql: String) -> Date? {
        return sqlFormatter.date(from: fromSql)
    }
    
    public func dateToHuman(fromSimpleSql: String) -> String {
        let date = simpleSqlFormatter.date(from: fromSimpleSql)
        return humamFormatter.string(from: date!)
    }
    
    public func dateToHuman(from: String, toFormat: String) -> String {
        let df = DateFormatter()
        df.dateFormat = toFormat
        if let date = sqlFormatter.date(from: from) {
            return df.string(from: date)
        }
        return ""
    }
    
    public func convertToDate(fromSimpleSql: String) -> Date? {
        return simpleSqlFormatter.date(from: fromSimpleSql)
    }
}

// MARK: - Staging App
open class StagingAppImpl: ProductionAppImpl {
	
	public override init() {
		super.init()
		self.config = StagingAppConfigImpl()
	}
}
