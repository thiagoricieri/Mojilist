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
    
    @IBOutlet weak var newListButton: PrimaryFloatingButton!
    @IBOutlet weak var storeButton: PrimaryFloatingButton!
    @IBOutlet weak var settingsBarItem: UIBarButtonItem!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyTitle: UILabel!
    @IBOutlet weak var emptyMsg: UILabel!
    @IBOutlet weak var downDecoration: UIImageView!
    @IBOutlet weak var emptyDecoration: UIImageView!
    
    var presenter: ListsPresenter!
    
    override func instantiateDependencies() {
        basePresenter = ListsPresenterImpl(view: self)
        presenter = basePresenter as! ListsPresenter
    }
    
    override func setViewStyle() {
        title = "Lists.Title".localized
        newListButton.setTitle("Lists.New".localized, for: .normal)
        emptyTitle.text = "Lists.Empty".localized
        emptyMsg.text = "Lists.Empty.Msg".localized
    }
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        theme.actionButton(newListButton)
        theme.primaryText(emptyTitle)
        theme.secondaryText(emptyMsg)
        
        downDecoration.image = UIImage(named: theme.downArrowDecoration())
        emptyDecoration.image = UIImage(named: theme.emptyBoxDecoration())
    }
    
    override func reload() {
        super.reload()
        emptyView.isHidden = presenter.sourceCount() > 0
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AsciiListCell.identifier) as! AsciiListCell
        
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
        return AsciiListCell.cellHeight
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
