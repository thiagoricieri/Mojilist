//
//  AboutPresenter.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 18/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import RealmSwift

protocol AboutPresenter: BaseDataPresenter {
    func item(at: Int, section: Int) -> SettingsOption
    func section(at: Int) -> SettingsGroup
    func defaultPackName() -> String
}

class AboutPresenterImpl: AboutPresenter {
    
    var view: AboutView!
    var source = [SettingsGroup]()
    
    init(view: AboutView) {
        self.view = view
    }
    
    func defaultPackName() -> String {
        let defaults = UserDefaults.standard
        if let pack = defaults.string(forKey: Env.App.defaultPack) {
            let packs = packFromRealm(slug: pack)
            if packs.count > 0 {
                return packs.first!.name
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.standardEmojiPack().name
    }
    
    func packFromRealm(slug: String) -> Results<REmojiPack> {
        let realm = view.provideRealm()
        let predicate = NSPredicate(format: "slug = %@", slug)
        return realm.objects(REmojiPack.self).filter(predicate)
    }
    
    func loadSource() {
        
        // Settings
        var settings = SettingsGroup()
        settings.title = "About.Settings".localized
        
        var theme = SettingsOption()
        theme.name = "About.Settings.Theme".localized
        theme.icon = "theme"
        
        var defaultPack = SettingsOption()
        defaultPack.name = "About.Settings.DefaultPack".localized
        defaultPack.icon = "pack"
        
        settings.items = [theme, defaultPack]
        
        // Promotion
        var promo = SettingsGroup()
        promo.title = "About.Promo".localized
        
        var signup = SettingsOption()
        signup.name = "About.Promo.Signup".localized
        signup.icon = "inbox"
        
        var share = SettingsOption()
        share.name = "About.Promo.Share".localized
        share.icon = "like"
        
        var rate = SettingsOption()
        rate.name = "About.Promo.Rate".localized
        rate.icon = "rate"
        
        promo.items = [signup, share, rate]
        
        // Follow
        var follow = SettingsGroup()
        follow.title = "About.Follow".localized
        
        var instagram = SettingsOption()
        instagram.name = "About.Follow.Instagram".localized
        instagram.icon = "instagram"
        
        var twitter = SettingsOption()
        twitter.name = "About.Follow.Twitter".localized
        twitter.icon = "twitter"
        
        var facebook = SettingsOption()
        facebook.name = "About.Follow.Facebook".localized
        facebook.icon = "facebook"
        
        var blog = SettingsOption()
        blog.name = "About.Follow.Blog".localized
        blog.icon = "safari"
        
        follow.items = [instagram, twitter, facebook, blog]
        
        // About
        var about = SettingsGroup()
        about.title = "About.About".localized
        
        var feature = SettingsOption()
        feature.name = "About.About.Feature".localized
        feature.icon = "mail"
        
        var contact = SettingsOption()
        contact.name = "About.About.Contact".localized
        contact.icon = "contact"
        
        var version = SettingsOption()
        version.name = "About.About.Version".localized
        version.cellIdentifier = .simple
        version.metadata = ["version": "1.0.0" as AnyObject]
        
        //var moreApps = SettingsOption()
        //moreApps.name = "About.MoreApps".localized
        //moreApps.cellIdentifier = ""
        //moreApps.icon = ""
        
        about.items = [feature, contact, version]
        
        // Assemble
        source = [settings, promo, follow, about]
    }
    
    func downloadSource() {
        // None
    }
    
    func sourceCount() -> Int {
        return source.count
    }
    
    func item(at: Int) -> AnyObject {
        return "" as AnyObject
    }
    
    func item(at: Int, section: Int) -> SettingsOption {
        return source[section].items[at]
    }
    
    func section(at: Int) -> SettingsGroup {
        return source[at]
    }
    
    // MARK: - Base Presenter
    func unload() {
        self.view = nil
    }
}

enum SettingsCellTypes: String {
    case simple = "SettingsSimple"
    case withIcon = "SettingsIcon"
    case actionable = "SettingsActionable"
}

struct SettingsGroup {
    
    var title = ""
    var items = [SettingsOption]()
}

struct SettingsOption {
    
    var name = ""
    var icon: String? = nil
    var cellIdentifier: SettingsCellTypes = .withIcon
    var metadata: [String: AnyObject]? = nil
}
