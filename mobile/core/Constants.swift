//
//  Constants.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - ENVIRONMENT
public struct Env {
    
    public enum Host : Int {
        case staging
        case production
    }
    
    public struct Key {
        static let userAgent = "User-Agent"
    }
    
    public struct Promo {
        static let shareUrl = "https://ghostship.co/mojilist"
        static let email = "buh@ghostship.co"
    }
    
    public struct App {
        static let theming = "app-theming"
        static let defaultPack = "default-pack"
        static let maxEmojisPerRow = 7
    }
}
