//
//  UsingListViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 12/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class UsingListViewController: BaseCollectionViewController {
    
    var viewModel: UsingListViewModel!
    var passListViewModel: EmojiListViewModel!
    
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var settingsButton: SecondaryFloatingButton!
    @IBOutlet weak var shareButton: SecondaryFloatingButton!
    @IBOutlet weak var topFadeDecoration: UIImageView!
    @IBOutlet weak var bottomFadeDecoration: UIImageView!
    
    override func instantiateDependencies() {
        baseViewModel = UsingListViewModel(list: passListViewModel)
        viewModel = baseViewModel as! UsingListViewModel
    }
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        theme.actionButton(doneButton)
        theme.background(self.view)
        theme.secondaryButton(shareButton)
        theme.secondaryButton(settingsButton)
        theme.primaryText(listNameLabel)
        
        topFadeDecoration.image = UIImage(named: theme.topDecoration())
        bottomFadeDecoration.image = UIImage(named: theme.bottomDecoration())
    }
    
    override func setViewStyle() {
        listNameLabel.text = viewModel.name
        doneButton.setTitle("UsingList.Done".localized, for: .normal)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func reload() {
        super.reload()
        setViewStyle()
    }
    
    // MARK: - Collection
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let emoji = viewModel.item(at: indexPath)
        
        if !emoji.hasImage {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AsciiEmojiCell.identifier, for: indexPath) as! AsciiEmojiCell
            cell.configure(with: emoji)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageEmojiCell.identifier, for: indexPath) as! ImageEmojiCell
            cell.configure(with: emoji)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.toggleEmoji(at: indexPath)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? BaseEmojiCell {
            cell.configure(with: viewModel.item(at: indexPath))
            cell.springView.animation = "pop"
            cell.springView.curve = "easeOut"
            cell.springView.duration = 0.5
            cell.springView.animate()
        }
        
        heavyImpact()
    }
    
    // MARK: - List Settings Options
    
    func redoList() {
        
        for cell in collection.visibleCells {
            let indexPath = collection.indexPath(for: cell)
            let emoji = viewModel.item(at: indexPath!)
            
            if let ccell = cell as? BaseEmojiCell, emoji.isChecked {
                ccell.springView.animation = "swing"
                ccell.springView.curve = "easeInOut"
                ccell.springView.duration = 0.7
                ccell.springView.animate()
                ccell.uncheckEmoji()
            }
        }
        
        viewModel.reuseList()
    }
    
    func settingsOptions() {
        let title = "UsingList.Settings.Title".localized
        let message = "UsingList.Settings.Msg".localized
        let popup = PopupDialog(title: title, message: message)
        
        let dismissButton = CancelButton(title: "Dismiss".localized) {
            print("You canceled the car dialog.")
        }
        
        let deleteButton = DestructiveButton(
                title: "UsingList.Settings.DeleteList".localized,
                dismissOnTap: true) {
                    
            self.confirmDeletion()
        }
        
        let reuseButton = DefaultButton(
                title: "UsingList.Settings.Redo".localized,
                dismissOnTap: true) {
                    
            self.redoList()
        }
        
        let editButton = DefaultButton(
                title: "UsingList.Settings.Edit".localized,
                dismissOnTap: true) {
            
            self.performSegue(
                withIdentifier: MainStoryboard.Segue.toEditList,
                sender: nil)
        }
        
        popup.addButtons([reuseButton, editButton, deleteButton, dismissButton])
        self.present(popup, animated: true, completion: nil)
    }
    
    func confirmDeletion() {
        let title = "UsingList.Settings.DeleteList".localized
        let message = "UsingList.Delete.Msg".localized
        let popup = PopupDialog(title: title, message: message)
        
        let dismissButton = CancelButton(title: "No".localized) { }
        let deleteButton = DestructiveButton(
                title: "UsingList.Settings.DeleteListConfirmation".localized,
                dismissOnTap: true) {
                    
            self.viewModel.deleteList()
            self.dismiss(animated: true)
        }
        
        popup.addButtons([dismissButton, deleteButton])
        self.present(popup, animated: true, completion: nil)
    }
    
    func shareList() {
        viewModel.trackSharing()
        Marketing.share(list: passListViewModel) { activityController in
            self.present(activityController, animated: true) { }
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainStoryboard.Segue.toEditList {
            let dest = segue.destination as! CreateListViewController
            dest.passListViewModel = viewModel.source
        }
    }
    
    // MARK: - Actions
    
    @IBAction func actionDone(sender: Any) {
        dismiss(animated: true, completion: nil)
        viewModel.trackCompletedList()
        mediumImpact()
    }
    
    @IBAction func actionSettings(sender: Any) {
        settingsOptions()
        lightImpact()
    }
    
    @IBAction func actionShare(sender: Any) {
        shareList()
        lightImpact()
    }
}

