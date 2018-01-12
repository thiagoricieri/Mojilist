//
//  SelectPackViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/12/2017.
//  Copyright © 2017 Ghost Ship. All rights reserved.
//

import UIKit

protocol SelectPackDelegate {
    func packSelected(pack: REmojiPack)
    func selectedPack() -> REmojiPack
}

protocol SelectPackView: BaseTableView {
}

class SelectPackViewController: BaseTableViewController, SelectPackView {
    
    @IBOutlet weak var newListButton: FloatButton!
    @IBOutlet weak var storeButton: FloatButton!
    
    var presenter: SelectPackPresenter!
    var delegate: SelectPackDelegate!
    
    override func instantiateDependencies() {
        basePresenter = SelectPackPresenterImpl(view: self)
        presenter = basePresenter as! SelectPackPresenter
    }
    
    override func prepareViewForUser() {
        super.prepareViewForUser()
    }
    
    override func setViewStyle() {
        title = "SelectPack.Title".localized
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = presenter.item(at: indexPath.row) as! REmojiPack
        let cell: BasePackCell!
        
        if item.ascii {
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
        let item = presenter.item(at: indexPath.row) as! REmojiPack
        delegate.packSelected(pack: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BasePackCell.cellHeight
    }
}
