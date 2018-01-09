//
//  StoryboardContext.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class StoryboardContext {
    
    var storyboard: UIStoryboard!
    
    init(){}
    init(name: String){
        storyboard = UIStoryboard(name: name, bundle: nil)
    }
    
    func controller(name: String) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: name)
    }
    
    func firstController() -> UIViewController {
        return storyboard.instantiateInitialViewController()!
    }
}
