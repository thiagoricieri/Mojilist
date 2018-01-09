//
//  Aliases.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation
import Alamofire
import AVFoundation

public typealias InBackgroundTuple = (URLRequest?, HTTPURLResponse?, Result<Any>)
public typealias InBackground = (URLRequest?, HTTPURLResponse?, Result<Any>) -> Void
public typealias InBackgroundResponse = (DataResponse<Any>) -> Void
public typealias ApiObject = NSObject
public typealias OnProcessFinished = (Bool, Any?) -> (Void)
public typealias Dict = [String: AnyObject]

public protocol Parametizable {
    func parametize() -> Dict
}
public protocol Objectable {
    func toApiObject() -> ApiObject
}
public protocol Routable {
}

public protocol Visibility {
    var isVisible : Bool { get set }
}
