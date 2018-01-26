//
//  ViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/12/2017.
//  Copyright © 2017 Ghost Ship. All rights reserved.
//

import UIKit
import Saw

class ListsViewController: BaseTableViewController {
    
    @IBOutlet weak var newListButton: PrimaryFloatingButton!
    @IBOutlet weak var storeButton: PrimaryFloatingButton!
    @IBOutlet weak var settingsBarItem: UIBarButtonItem!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyTitle: UILabel!
    @IBOutlet weak var emptyMsg: UILabel!
    @IBOutlet weak var downDecoration: UIImageView!
    @IBOutlet weak var emptyDecoration: UIImageView!
    
    var viewModel: ListsViewModel!
    
    override func instantiateDependencies() {
        baseViewModel = ListsViewModel()
        viewModel = baseViewModel as! ListsViewModel
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
        emptyView.isHidden = viewModel.itemsCount > 0
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AsciiListCell.identifier) as! AsciiListCell
        
        let item = viewModel.item(at: indexPath)
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(
            withIdentifier: MainStoryboard.Segue.toUsingList,
            sender: viewModel.item(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AsciiListCell.cellHeight
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainStoryboard.Segue.toUsingList {
            let dest = segue.destination as! UINavigationController
            let vc = dest.viewControllers.first! as! UsingListViewController
            vc.passListViewModel = sender as! EmojiListViewModel
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func actionNewList(_ sender: UIView) {
        performSegue(withIdentifier: MainStoryboard.Segue.toCreate, sender: nil)
    }
    
    @IBAction func actionStore(_ sender: UIView) {
        successAlert(message: "Open Store!")
    }
    
    @IBAction func actionSettings(_ sender: Any) {
        performSegue(withIdentifier: MainStoryboard.Segue.toSettings, sender: nil)
    }
}
