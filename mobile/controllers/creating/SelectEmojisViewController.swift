//
//  SelectEmojisViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

protocol SelectEmojisView: BaseView {
    
    func updateEmojiInListCount(to: Int)
    func listCreated()
}

class SelectEmojisViewController: BaseCollectionViewController,
        SelectEmojisView,
        SelectPackDelegate {
    
    var listName: String!
    var presenter: SelectEmojisPresenter!
    
    @IBOutlet weak var animationContainer: UIView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var selectedPackButton: UIButton!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeCountLabel: UILabel!
    @IBOutlet weak var clearBarItem: UIBarButtonItem!
    
    override func instantiateDependencies() {
        basePresenter = SelectEmojisPresenterImpl(view: self)
        presenter = basePresenter as! SelectEmojisPresenter
        
        // Start using default pack:
        presenter.pack = appDelegate.standardEmojiPack()
    }
    
    override func setViewStyle() {
        title = "SelectEmojis.Title".localized
        createButton.setTitle("SelectEmojis.Create".localized, for: .normal)
        createButton.setTitle("SelectEmojis.Create".localized, for: .disabled)
        clearBarItem.title = "SelectEmojis.Clear".localized
        badgeView.layer.cornerRadius = badgeView.bounds.width/2
        badgeView.clipsToBounds = true
    }
    
    override func reload() {
        super.reload()
        
        let packName = "SelectEmojis.SelectPack".localized + " \(presenter.pack.name)"
        selectedPackButton.setTitle(packName, for: .normal)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let emoji = presenter.item(at: indexPath.row) as! REmojiPackItem
        
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
        presenter.selectEmoji(at: indexPath.row)
    }
    
    func updateEmojiInListCount(to: Int) {
        if to > 0 {
            badgeView.isHidden = false
            createButton.isEnabled = true
            badgeCountLabel.text = String(to)
        } else {
            badgeView.isHidden = true
            createButton.isEnabled = false
        }
    }
    
    func listCreated() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Connect to Selection of Pack
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainStoryboard.Segue.toSelectPack {
            let dest = segue.destination as! SelectPackViewController
            dest.delegate = self
        }
    }
    
    func packSelected(pack: REmojiPack) {
        presenter.pack = pack
        navigationController?.popViewController(animated: true)
        reload()
    }
    
    func selectedPack() -> REmojiPack {
        return presenter.pack
    }
    
    // MARK: - Actions
    @IBAction func actionCreate(sender: Any) {
        presenter.createList(with: listName)
    }
    
    @IBAction func actionSelectedPack(sender: Any) {
        performSegue(withIdentifier: MainStoryboard.Segue.toSelectPack, sender: nil)
    }
    
    @IBAction func actionClear(_ sender: Any) {
        presenter.clearList()
    }
}
