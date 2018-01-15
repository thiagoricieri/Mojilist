//
//  Analytics.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 15/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import Firebase

class Tracker {
    
    static func newList(itemsCount: Int) {
        Analytics.logEvent("new_list", parameters: [
            "items_count": itemsCount as NSObject
        ])
    }
    
    static func changedPack(packSlug: String) {
        Analytics.logEvent("changed_pack", parameters: [
            "slug": packSlug as NSObject
        ])
    }
    
    static func completeList(itemsCount: Int, itemsUsed: Int) {
        Analytics.logEvent("complete_list", parameters: [
            "items_count": itemsCount as NSObject,
            "items_used": itemsUsed as NSObject
        ])
    }
    
    static func deleteList(itemsCount: Int) {
        Analytics.logEvent("delete_list", parameters: [
            "items_count": itemsCount as NSObject,
        ])
    }
    
    static func reusedList(itemsCount: Int) {
        Analytics.logEvent("reused_list", parameters: [
            "items_count": itemsCount as NSObject,
        ])
    }
    
    static func changedTheme(themeSlug: String) {
        Analytics.logEvent("changed_theme", parameters: [
            "slug": themeSlug as NSObject
        ])
    }
    
    static func shareImage() {
        Analytics.logEvent("share_image", parameters: nil)
    }
    
    static func shareApp() {
        Analytics.logEvent("share_app", parameters: nil)
    }
    
    static func rateApp(rating: Int) {
        Analytics.logEvent("rate_app", parameters: [
            "rating": rating as NSObject
        ])
    }
    
    static func followInstagram() {
        Analytics.logEvent("follow_instagram", parameters: nil)
    }
    
    static func followTwitter() {
        Analytics.logEvent("follow_twitter", parameters: nil)
    }
    
    static func signupNewsletter() {
        Analytics.logEvent("signup_newsletter", parameters: nil)
    }
    
    static func contactDeveloper() {
        Analytics.logEvent("contact_developer", parameters: nil)
    }
}
