//
//  SelectPackViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/12/2017.
//  Copyright © 2017 Ghost Ship. All rights reserved.
//

import UIKit

protocol SelectPackDelegate {
    func packSelected(pack: EmojiPackViewModel)
    func selectedPack() -> EmojiPackViewModel
}

class SelectPackViewController: BaseTableViewController {
    
    @IBOutlet weak var newListButton: PrimaryFloatingButton!
    @IBOutlet weak var storeButton: PrimaryFloatingButton!
    
    var viewModel: SelectPackViewModel!
    var delegate: SelectPackDelegate!
    
    override func instantiateDependencies() {
        baseViewModel = SelectPackViewModel()
        viewModel = baseViewModel as! SelectPackViewModel
    }
    
    override func setViewStyle() {
        title = "SelectPack.Title".localized
    }
    
    // MARK: - Table View Boilerplate
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.item(at: indexPath)
        let cell: BasePackCell!
        
        if item.isTextual {
            cell = tableView.dequeueReusableCell(
                withIdentifier: AsciiPackCell.identifier) as! AsciiPackCell
        } else {
            cell = tableView.dequeueReusableCell(
                withIdentifier: ImagePackCell.identifier) as! ImagePackCell
        }
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath)
        viewModel.trackChanged(toPack: item)
        delegate.packSelected(pack: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BasePackCell.cellHeight
    }
}
