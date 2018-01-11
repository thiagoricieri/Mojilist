//
//  MainStoryboard.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

class MainStoryboard: StoryboardContext {
    
    struct Segue {
        static let toCreate = "toCreate"
    }
    
    func createListViewController() -> CreateListViewController {
        return controller(name: "CreateList") as! CreateListViewController
    }
}
