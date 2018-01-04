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
}

// MARK: - Visuals
public struct Visuals {
    
    // Typefaces
    public enum Typeface : String {
        case DinProBold = "DINPro-CondBold"
    }
    
    // Colors
    public enum Colors : Int {
        case grayLight = 0xA6A6A6
        func color() -> UIColor {
            return UIColorFromRGB(rgb: UInt(self.rawValue))
        }
    }
}

// MARK: - Credentials
protocol Credentials {
    static var clientId : String { get }
    static var clientSecret : String { get }
}
