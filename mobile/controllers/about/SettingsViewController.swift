//
//  SettingsViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
import Saw

class SettingsViewController: BaseTableViewController,
        MFMailComposeViewControllerDelegate {
    
    var viewModel: SettingsViewModel!
    
    override func instantiateDependencies() {
        baseViewModel = SettingsViewModel()
        viewModel = baseViewModel as! SettingsViewModel
    }
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        if let color = theme.visuals.separatorColor {
            table.separatorColor = theme.color(color)
        }
    }
    
    override func setViewStyle() {
        title = "About.Title".localized
    }
    
    // MARK: - Table
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.item(at: indexPath)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: item.cellIdentifier.rawValue) as! SettingsCell
        
        let theme = viewModel.theme!
        theme.cellBackground(cell)
        theme.primaryText(cell.textLabel!)
        
        if let dt = cell.detailTextLabel { theme.secondaryText(dt) }
        
        cell.option = item
        cell.textLabel?.text = item.name.localized
        
        if let i = item.icon, let im = cell.imageView {
            im.image = UIImage(named: i)?.withRenderingMode(.alwaysTemplate)
            theme.accent(im)
        } else {
            cell.imageView?.image = nil
        }
        
        // Specific to some:
        if  item.name == "About.About.Version",
            let v = item.metadata!["version"] as? String {
            cell.detailTextLabel?.text = v
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        // Settings
        if item.name.contains("About.Settings.DefaultPack") {
            cell.textLabel?.text = "\(item.name.localized) \(viewModel.defaultPackName.localized)"
        }
        else if item.name.contains("About.Settings.Theme") {
            cell.textLabel?.text = "\(item.name.localized) \(theme.identifier().localized)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = viewModel.item(at: indexPath)
        
        if item.name == "About.MoreApps" {
            // None
        }
        else if item.name.contains("About.Settings.DefaultPack") {
            
        }
        else if item.name.contains("About.Settings.Theme") {
            performSegue(withIdentifier: AboutStoryboard.Segue.toChangeTheme, sender: nil)
        }
        else if item.name.contains("About.Promo.Share") {
            Tracker.shareApp()
            Marketing.share { controller in
                self.present(controller, animated: true)
            }
        }
        else if item.name.contains("About.Promo.Rate") {
            Tracker.rateApp()
            SKStoreReviewController.requestReview()
        }
        else if item.name.contains("About.Promo.Signup") {
            Tracker.signupNewsletter()
            performSegue(
                withIdentifier: AboutStoryboard.Segue.toWebView,
                sender: item.metadata!["url"])
        }
        else if item.name.contains("About.Follow.Instagram") {
            Tracker.followInstagram()
            performSegue(
                withIdentifier: AboutStoryboard.Segue.toWebView,
                sender: item.metadata!["url"])
        }
        else if item.name.contains("About.Follow.Facebook") {
            Tracker.followFacebook()
            performSegue(
                withIdentifier: AboutStoryboard.Segue.toWebView,
                sender: item.metadata!["url"])
        }
        else if item.name.contains("About.Follow.Twitter") {
            Tracker.followTwitter()
            performSegue(
                withIdentifier: AboutStoryboard.Segue.toWebView,
                sender: item.metadata!["url"])
        }
        else if item.name.contains("About.Follow.Blog") {
            Tracker.followBlog()
            performSegue(
                withIdentifier: AboutStoryboard.Segue.toWebView,
                sender: item.metadata!["url"])
        }
        else if item.name.contains("About.About.Contact") ||
            item.name.contains("About.About.Feature") {
            
            Tracker.contactDeveloper()
            sendEmail(subject: item.metadata!["subject"] as! String)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.section(at: section).title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.section(at: section).items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.itemsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    // MARK: - Mail Delegate
    
    func sendEmail(subject: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([Env.Promo.email])
            mail.setSubject(subject)
            present(mail, animated: true)
        }
        else {
            errorAlert(message: "Email.Error".localized)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AboutStoryboard.Segue.toWebView {
            let dest = segue.destination as! WebViewController
            dest.url = sender as! String
        }
    }
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class SettingsCell: UITableViewCell {
    var option: SettingsOption!
}
