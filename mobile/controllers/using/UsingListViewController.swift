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

protocol UsingListView: BaseCollectionView {
    
    func listDeleted()
    func shareList()
}

class UsingListViewController: BaseCollectionViewController, UsingListView {
    
    var presenter: UsingListPresenter!
    var emojiList: REmojiList!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func instantiateDependencies() {
        basePresenter = UsingListPresenterImpl(view: self)
        presenter = basePresenter as! UsingListPresenter
        presenter.source = emojiList.emojis
    }
    
    override func setViewStyle() {
        listNameLabel.text = emojiList.name
        doneButton.setTitle("UsingList.Done".localized, for: .normal)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let emoji = presenter.item(at: indexPath.row) as! REmoji
        
        if emoji.imageUrl.isEmpty {
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
        presenter.toggleEmoji(at: indexPath.row)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? BaseEmojiCell {
            cell.configure(with: presenter.item(at: indexPath.row) as! REmoji)
            cell.springView.animation = "pop"
            cell.springView.curve = "easeOut"
            cell.springView.duration = 0.5
            cell.springView.animate()
        }
        
        heavyImpact()
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
        
        let shareButton = DefaultButton(
                title: "UsingList.Settings.ShareList".localized,
                dismissOnTap: true) {
            self.presenter.shareList(list: self.emojiList)
        }
        
        popup.addButtons([dismissButton, deleteButton, shareButton])
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
            self.presenter.deleteList(list: self.emojiList)
        }
        
        popup.addButtons([dismissButton, deleteButton])
        self.present(popup, animated: true, completion: nil)
    }
    
    func shareList() {
        let firstActivityItem = "\(emojiList.name) #mojilist"
        let secondActivityItem = URL(string: Env.App.shareUrl)!
        let image = UIImage(view: self.view)
        
        let activityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem, image],
                applicationActivities: nil)
        
        self.present(activityViewController, animated: true) { }
    }
    
    func listDeleted() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionDone(sender: Any) {
        dismiss(animated: true, completion: nil)
        mediumImpact()
    }
    
    @IBAction func actionSettings(sender: Any) {
        settingsOptions()
        lightImpact()
    }
    
    @IBAction func actionRedo(sender: Any) {
        for cell in collection.visibleCells {
            let indexPath = collection.indexPath(for: cell)
            let emoji = presenter.item(at: indexPath!.row) as! REmoji
            
            if let ccell = cell as? BaseEmojiCell, emoji.checked {
                ccell.springView.animation = "swing"
                ccell.springView.curve = "easeInOut"
                ccell.springView.duration = 0.7
                ccell.springView.animate()
                ccell.uncheckEmoji()
            }
        }
        
        presenter.resetCheckedEmojis()
        lightImpact()
    }

    deinit {
        presenter.unload()
        presenter = nil
    }
}

