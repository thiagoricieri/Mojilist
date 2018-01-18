//
//  AboutViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import UIKit

protocol AboutView: BaseView {
}

class AboutViewController: BaseTableViewController, AboutView {
    
    var presenter: AboutPresenter!
    
    override func instantiateDependencies() {
        basePresenter = AboutPresenterImpl(view: self)
        presenter = basePresenter as! AboutPresenterImpl
    }
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
    }
    
    override func setViewStyle() {
        title = "About.Title".localized
    }
    
    // MARK: - Table
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = presenter.item(at: indexPath.row, section: indexPath.section)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: item.cellIdentifier.rawValue) as! SettingsCell
        
        cell.option = item
        cell.textLabel?.text = item.name
        
        if let i = item.icon {
            cell.imageView?.image = UIImage(named: i)
        } else {
            cell.imageView?.image = nil
        }
        
        // Specific to some:
        if  item.name == "About.About.Version".localized,
            let v = item.metadata!["version"] as? String {
            cell.detailTextLabel?.text = v
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        // Settings
        if item.name.contains("About.Settings.DefaultPack".localized) {
            cell.textLabel?.text = "\(item.name) \(presenter.defaultPackName())"
        }
        else if item.name.contains("About.Settings.Theme".localized) {
            cell.textLabel?.text = "\(item.name) \(provideApp().theme.identifier().localized)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = presenter.item(at: indexPath.row, section: indexPath.section)
        
        if item.name == "About.MoreApps".localized {
            // None
        }
        else if item.name.contains("About.Settings.DefaultPack".localized) {
            
        }
        else if item.name.contains("About.Settings.Theme".localized) {
            
        }
        else if item.name.contains("About.Promo.Signup".localized) {
            
        }
        else if item.name.contains("About.Promo.Share".localized) {
            
        }
        else if item.name.contains("About.Promo.Rate".localized) {
            
        }
        else if item.name.contains("About.Follow.Instagram".localized) {
            
        }
        else if item.name.contains("About.Follow.Facebook".localized) {
            
        }
        else if item.name.contains("About.Follow.Twitter".localized) {
            
        }
        else if item.name.contains("About.Follow.Blog".localized) {
            
        }
        else if item.name.contains("About.About.Contact".localized) {
            
        }
        else if item.name.contains("About.About.Feature".localized) {
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.section(at: section).title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.section(at: section).items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sourceCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class SettingsCell: UITableViewCell {
    var option: SettingsOption!
}
