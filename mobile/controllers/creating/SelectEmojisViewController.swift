//
//  SelectEmojisViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import Spring

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
    @IBOutlet weak var badgeView: SpringView!
    @IBOutlet weak var badgeCountLabel: UILabel!
    @IBOutlet weak var clearBarItem: UIBarButtonItem!
    
    // Extra collection
    @IBOutlet weak var basketCollection: UICollectionView!
    
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
        
        let emoji: REmojiPackItem!
        
        if collectionView == collection {
            emoji = presenter.item(at: indexPath.row) as! REmojiPackItem
        } else {
            emoji = presenter.selectedItem(at: indexPath.row)
        }
        
        if emoji.imageUrl.isEmpty {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AsciiEmojiCell.identifier, for: indexPath) as! AsciiEmojiCell
            cell.configure(with: emoji)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageEmojiCell.identifier, for: indexPath) as! ImageEmojiCell
            cell.configure(with: emoji)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == collection else { return }
        
        collectionView.deselectItem(at: indexPath, animated: false)
        presenter.selectEmoji(at: indexPath.row)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? BaseEmojiCell {
            cell.springView.animation = "pop"
            cell.springView.curve = "easeOut"
            cell.springView.duration = 0.5
            cell.springView.animate()
        }
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        let basketIndex = IndexPath(
            item: 0,
            section: 0)
        
        basketCollection.performBatchUpdates({
            self.basketCollection.insertItems(at: [basketIndex])
        }, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection {
            return presenter.sourceCount()
        } else {
            return presenter.selectedCount()
        }
    }
    
    func updateEmojiInListCount(to: Int) {
        if to > 0 {
            badgeView.isHidden = false
            createButton.isEnabled = true
            badgeCountLabel.text = String(to)
            badgeView.animation = "pop"
            badgeView.curve = "easeInOut"
            badgeView.animate()
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
        var allIndexes = [IndexPath]()
        for i in 0...presenter.selectedCount() - 1 {
            allIndexes.append(IndexPath(item: i, section: 0))
        }
        
        presenter.clearList()
        
        basketCollection.performBatchUpdates({
            self.basketCollection.deleteItems(at: allIndexes)
        }, completion: nil)
    }
}
