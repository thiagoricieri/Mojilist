//
//  Sharing.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 15/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class Marketing {
    
    static func shareApp(_ controllerReady: (UIActivityViewController) -> Void) {
        let copyToShare = "About.Share.Copy".localized + " " + Env.Promo.shareUrl
        let urlToShare = URL(string: Env.Promo.shareUrl)!
        let activityViewController = UIActivityViewController(
            activityItems: [copyToShare, urlToShare],
            applicationActivities: nil)
        controllerReady(activityViewController)
    }
    
    static func shareActivity(object: REmojiList, controllerReady: (UIActivityViewController) -> Void) {
        let firstActivityItem = "\(object.name) #mojilist"
        let secondActivityItem = URL(string: Env.Promo.shareUrl)!
        let shareView = Bundle.loadView(fromNib: Xibs.resources, withType: ShareSnippetView.self)
        shareView.configure(with: object)
        
        let image = UIImage(view: shareView)
        let activityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image],
            applicationActivities: nil)
        
        controllerReady(activityViewController)
    }
}
