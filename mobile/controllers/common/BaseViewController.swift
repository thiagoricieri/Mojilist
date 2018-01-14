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

open class BaseViewController : UIViewController, BaseView {
    
    var appDelegate: AppDelegate {
        get { return UIApplication.shared.delegate as! AppDelegate }
    }
    
    var basePresenter: BasePresenter!
    
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
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        instantiateDependencies()
        setViewStyle()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareViewForUser()
    }
    
    open func instantiateDependencies() {
    }
    
    open func setViewStyle() {
    }
    
    open func prepareViewForUser() {
    }
    
    deinit {
        basePresenter.unload()
        basePresenter = nil
    }
}

// MARK: - HUD
extension BaseViewController {
    
    open func hudShow (message: String? = nil) {
        currentHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        currentHud?.mode = .indeterminate
        
        if message != nil {
            currentHud?.label.text = message!
        }
    }
    
    open func hudDismiss() {
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
