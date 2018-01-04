//
//  Foundation+Extensions.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation

// MARK: - Optionals
extension Optional {
    func unwrapOrElse(_ val:Wrapped) -> Wrapped  {
        if self != nil {
            return self!
        } else {
            return val
        }
    }
    
    func isNil() -> Bool {
        return self == nil
    }
    
    func isNotNil() -> Bool {
        return self != nil
    }
}

// MARK: - Debug
extension NSObject {
    
    // Print + Name
    func pn(_ message: String) {
        #if DEBUG
            print("[\(type(of: self))] \(message)")
        #endif
    }
    
    // Just print
    func pr(_ message: String) {
        #if DEBUG
            print("\(message)")
        #endif
    }
    
    // Print + Name + Date
    func pd(_ message: String) {
        #if DEBUG
            let date = Date()
            pn("at \(date): \(message)")
        #endif
    }
}

// MARK: - Localizable
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    func localizedWithComment(_ comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
}
