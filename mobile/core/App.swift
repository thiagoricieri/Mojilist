//
//  App.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation
import DateToolsSwift
import RealmSwift
import Saw

// MARK: - Production App
class MojilistProductionAppImpl: ProductionAppImpl {
    
    fileprivate func initTheme() -> Theme {
        let defaults = UserDefaults.standard
        if let theme = defaults.string(forKey: Env.App.theming) {
            return Theme(visualString: theme)
        }
        return Theme(visuals: BasicVisual())
    }
	
    func standardEmojiPack() -> EmojiPackViewModel {
        let pack = realm.objects(REmojiPack.self).filter("ascii = true").first!
        return EmojiPackViewModel(with: pack)
    }
    
    override public func changeVisuals(_ visuals: Visuals) {
        theme.visuals = visuals
        let defaults = UserDefaults.standard
        defaults.set(visuals.identifier, forKey: Env.App.theming)
        
        if UIApplication.shared.supportsAlternateIcons {
            UIApplication.shared.setAlternateIconName(visuals.icon)
        }
    }
}

// MARK: - Staging App
class MojilistStagingAppImpl: MojilistProductionAppImpl {
	
	public override init() {
		super.init()
		self.config = StagingAppConfigImpl()
	}
}
