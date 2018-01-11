//
//  ViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/12/2017.
//  Copyright © 2017 Ghost Ship. All rights reserved.
//

import UIKit

protocol ListsView: BaseTableView {
}

class ListsViewController: BaseTableViewController, ListsView {
    
    @IBOutlet weak var newListButton: FloatButton!
    @IBOutlet weak var storeButton: FloatButton!
    
    override func instantiateDependencies() {
        presenter = ListsPresenterImpl(view: self)
    }
    
    override func setViewStyle() {
        title = "Lists.Title".localized
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as! ListCell
        
        let item = presenter.item(at: indexPath.row) as! REmojiList
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListCell.cellHeight
    }
    
    // MARK: - Button Actions
    @IBAction func actionNewList(_ sender: UIView) {
        performSegue(withIdentifier: MainStoryboard.Segue.toCreate, sender: nil)
    }
    
    @IBAction func actionStore(_ sender: UIView) {
        successAlert(message: "Open Store!")
    }
}
