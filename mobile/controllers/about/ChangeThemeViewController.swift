//
//  ChangeThemeViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 18/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

protocol ChangeThemeView: BaseView {
}

class ChangeThemeViewController: BaseTableViewController,
        ChangeThemeView {
    
    var presenter: ChangeThemePresenterImpl!
    
    override func instantiateDependencies() {
        basePresenter = ChangeThemePresenterImpl(view: self)
        presenter = basePresenter as! ChangeThemePresenterImpl
    }
    
    override func setViewStyle() {
        title = "ChangeTheme.Title".localized
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Theme")!
        let newVisuals = presenter.visual(at: indexPath.row)
        
        let theme = provideApp().theme
        theme.cellBackground(cell)
        theme.primaryText(cell.textLabel!)
        
        cell.textLabel?.text = newVisuals.identifier.localized
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newVisuals = presenter.visual(at: indexPath.row)
        provideApp().changeVisuals(newVisuals)
        applyTheme(provideApp().theme)
        reload()
    }
}

