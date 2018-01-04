//
//  Funcs.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation
import UIKit

func UIColorFromRGB(rgb: UInt) -> UIColor {
    return UIColor(
        red: 	CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
        green: 	CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
        blue: 	CGFloat(rgb & 0x0000FF) / 255.0,
        alpha: 	CGFloat(1.0)
    )
}
