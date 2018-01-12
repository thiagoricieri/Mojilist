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
    @IBOutlet weak var settingsBarItem: UIBarButtonItem!
    
    var presenter: ListsPresenter!
    
    override func instantiateDependencies() {
        basePresenter = ListsPresenterImpl(view: self)
        presenter = basePresenter as! ListsPresenter
    }
    
    override func setViewStyle() {
        title = "Lists.Title".localized
        newListButton.setTitle("Lists.New".localized, for: .normal)
        settingsBarItem.title = "Lists.Settings".localized
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as! ListCell
        
        let item = presenter.item(at: indexPath.row) as! REmojiList
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(
            withIdentifier: MainStoryboard.Segue.toUsingList,
            sender: presenter.item(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListCell.cellHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainStoryboard.Segue.toUsingList {
            let dest = segue.destination as! UsingListViewController
            dest.emojiList = sender as! REmojiList
        }
    }
    
    // MARK: - Button Actions
    @IBAction func actionNewList(_ sender: UIView) {
        performSegue(withIdentifier: MainStoryboard.Segue.toCreate, sender: nil)
    }
    
    @IBAction func actionStore(_ sender: UIView) {
        successAlert(message: "Open Store!")
    }
}
