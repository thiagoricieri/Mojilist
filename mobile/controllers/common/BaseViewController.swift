//
//  BaseViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import RealmSwift

class BaseViewController : UIViewController, BaseView {
    
    var appDelegate: AppDelegate {
        get { return UIApplication.shared.delegate as! AppDelegate }
    }
    
    var basePresenter: BasePresenter!
    var currentTheme: String?
    
    fileprivate(set) var currentHud: MBProgressHUD?
    fileprivate(set) var previousBottomBar : UIView?
    
    // Inheritage Scroll View
    @IBOutlet weak var scrollView: UIScrollView?
    
    func provideApp() -> App {
        return appDelegate.app
    }
    func provideRealm() -> Realm {
        return provideApp().realm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateDependencies()
        let appTheme = provideApp().theme.identifier()
        if currentTheme == nil || currentTheme != appTheme {
            currentTheme = appTheme
            applyTheme(provideApp().theme)
        }
        setViewStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareViewForUser()
    }
    
    func instantiateDependencies() {
    }
    
    func applyTheme(_ theme: Theme) {
        theme.background(self.view)
        theme.tintAccent(self.view)
        
        if let nc = navigationController {
            theme.styleNavigationBar(nc.navigationBar)
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func setViewStyle() {
    }
    
    func prepareViewForUser() {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return provideApp().theme.statusBarStyle()
    }
    
    deinit {
        basePresenter.unload()
        basePresenter = nil
    }
}

// MARK: - HUD
extension BaseViewController {
    
    func hudShow (message: String? = nil) {
        currentHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        currentHud?.mode = .indeterminate
        
        if message != nil {
            currentHud?.label.text = message!
        }
    }
    
    func hudDismiss() {
        if currentHud != nil {
            currentHud?.hide(animated: true)
            currentHud = nil
        }
    }
}

// MARK: - Impact Generator
extension BaseViewController {
    
    func heavyImpact() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    func mediumImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func lightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Observing Keyboard
extension BaseViewController {
    
    func keyboardAppear(notification: Notification) {
        if  let safeScroll = self.scrollView {
            var contentInset = UIEdgeInsets.zero
            if  let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            }
            safeScroll.contentInset = contentInset
        }
    }
    
    func keyboardDisappear(notification: Notification) {
        if  let safeScroll = self.scrollView {
            safeScroll.contentInset = UIEdgeInsets.zero
        }
    }
    
    func alertViewWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorAlert(message: String) {
        alertViewWithTitle(title: "Warning".localized, message: message)
    }
    
    func successAlert(message: String) {
        alertViewWithTitle(title: "Success".localized, message: message)
    }
}

// MARK: - API Errors Warnings
extension BaseViewController {
    
    func errorWarningFromAPI(_ response: Any?) {
        if  let obj = response as? [AnyHashable: AnyObject],
            let message = obj["message"] as? String {
            self.errorAlert(message: message)
        } else {
            self.errorAlert(message: "\(String(describing: response))")
        }
    }
}
