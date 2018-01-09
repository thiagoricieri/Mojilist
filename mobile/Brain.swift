//
//  Brain.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

open class Brain {
    open static var app: App = {
        #if DEBUG
            return StagingAppImpl()
        #else
            return ProductionAppImpl()
        #endif
    }()
}
