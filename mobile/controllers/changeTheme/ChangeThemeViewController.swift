//
//  ChangeThemeViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 18/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class ChangeThemeViewController: BaseTableViewController {
    
    var viewModel: ChangeThemeViewModel!
    
    override func instantiateDependencies() {
        baseViewModel = ChangeThemeViewModel()
        viewModel = baseViewModel as! ChangeThemeViewModel
    }
    
    override func setViewStyle() {
        title = "ChangeTheme.Title".localized
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Theme")!
        let newVisuals = viewModel.item(at: indexPath.row)
        
        let theme = viewModel.theme!
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
        
        let newVisuals = viewModel.item(at: indexPath.row)
        viewModel.changeVisuals(newVisuals)
        applyTheme(viewModel.theme)
        reload()
    }
}

