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
        settings.title = "About.Settings"
        
        var theme = SettingsOption()
        theme.name = "About.Settings.Theme"
        theme.icon = "theme"
        
        var defaultPack = SettingsOption()
        defaultPack.name = "About.Settings.DefaultPack"
        defaultPack.icon = "pack"
        
        settings.items = [theme, defaultPack]
        
        // Promotion
        var promo = SettingsGroup()
        promo.title = "About.Promo"
        
        var signup = SettingsOption()
        signup.name = "About.Promo.Signup"
        signup.icon = "inbox"
        signup.metadata = [
            "url": "https://ghostship.us17.list-manage.com/subscribe?u=c95fc7c29b150bc1b79053748&id=ddd4ee4e1f" as AnyObject
        ]
        
        var share = SettingsOption()
        share.name = "About.Promo.Share"
        share.icon = "like"
        
        var rate = SettingsOption()
        rate.name = "About.Promo.Rate"
        rate.icon = "rate"
        
        promo.items = [signup, share, rate]
        
        // Follow
        var follow = SettingsGroup()
        follow.title = "About.Follow"
        
        var instagram = SettingsOption()
        instagram.name = "About.Follow.Instagram"
        instagram.icon = "instagram"
        instagram.metadata = [
            "url": "https://instagram.com/_ghostship_" as AnyObject
        ]
        
        var twitter = SettingsOption()
        twitter.name = "About.Follow.Twitter"
        twitter.icon = "twitter"
        twitter.metadata = [
            "url": "https://twitter.com/ghostship__" as AnyObject
        ]
        
        var facebook = SettingsOption()
        facebook.name = "About.Follow.Facebook"
        facebook.icon = "facebook"
        facebook.metadata = [
            "url": "https://facebook.com/ghostshiptech" as AnyObject
        ]
        
        var blog = SettingsOption()
        blog.name = "About.Follow.Blog"
        blog.icon = "safari"
        blog.metadata = [
            "url": "https://ghostship.co" as AnyObject
        ]
        
        follow.items = [instagram, twitter, facebook, blog]
        
        // About
        var about = SettingsGroup()
        about.title = "About.About"
        
        var feature = SettingsOption()
        feature.name = "About.About.Feature"
        feature.icon = "mail"
        feature.metadata = ["subject": "" as AnyObject]
        
        var contact = SettingsOption()
        contact.name = "About.About.Contact"
        contact.icon = "contact"
        contact.metadata = ["subject": "" as AnyObject]
        
        var version = SettingsOption()
        version.name = "About.About.Version"
        version.cellIdentifier = .simple
        let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        let appVersion = nsObject as! String
        version.metadata = ["version": appVersion as AnyObject]
        
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
