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
    
    func listCreated()
    func addIndexToBasked(_ indexPath: IndexPath)
    func removeIndexFromBasket(_ indexPath: IndexPath)
    func updateEmojiInListCount(to: Int)
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
    @IBOutlet weak var itemsInListLabel: UILabel!
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var topFadeDecoration: UIImageView!
    @IBOutlet weak var bottomFadeDecoration: UIImageView!
    @IBOutlet weak var indicatorDecoration: UIImageView!
    
    // Extra collection
    @IBOutlet weak var basketCollection: UICollectionView!
    
    override func instantiateDependencies() {
        basePresenter = SelectEmojisPresenterImpl(view: self)
        presenter = basePresenter as! SelectEmojisPresenter
        
        let defaults = UserDefaults.standard
        let realm = provideRealm()
        if let pack = defaults.string(forKey: Env.App.defaultPack) {
            let predicate = NSPredicate(format: "slug = %@", pack)
            let packs = realm.objects(REmojiPack.self).filter(predicate)
            if packs.count > 0 {
                presenter.pack = packs.first!
            }
        } else {
            presenter.pack = appDelegate.standardEmojiPack()
        }
    }
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        theme.separator(separator)
        theme.background(basketCollection)
        theme.actionButton(createButton)
        theme.badge(badgeView)
        
        topFadeDecoration.image = UIImage(named: theme.topDecoration())
        bottomFadeDecoration.image = UIImage(named: theme.bottomDecoration())
        indicatorDecoration.image = UIImage(named: theme.indicatorDecoration())
    }
    
    override func setViewStyle() {
        title = listName
        createButton.setTitle("SelectEmojis.Create".localized, for: .normal)
        createButton.setTitle("SelectEmojis.Create".localized, for: .disabled)
        clearBarItem.title = "SelectEmojis.Clear".localized
        itemsInListLabel.text = "SelectEmojis.ItemsInList".localized
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
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if collectionView == collection {
            presenter.selectEmoji(at: indexPath.row)
            
            if let cell = collectionView.cellForItem(at: indexPath) as? BaseEmojiCell {
                cell.springView.animation = "pop"
                cell.springView.curve = "easeOut"
                cell.springView.duration = 0.5
                cell.springView.animate()
            }
            
            lightImpact()
            addIndexToBasked(IndexPath(item: 0, section: 0))
        }
        else {
            presenter.removeEmoji(at: indexPath.row)
            
            lightImpact()
            removeIndexFromBasket(indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection {
            return presenter.sourceCount()
        } else {
            return presenter.selectedCount()
        }
    }
    
    func listCreated() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func packSelected(pack: REmojiPack) {
        presenter.pack = pack
        navigationController?.popViewController(animated: true)
        reload()
    }
    
    func selectedPack() -> REmojiPack {
        return presenter.pack
    }
    
    func addIndexToBasked(_ indexPath: IndexPath) {
        basketCollection.performBatchUpdates({
            self.basketCollection.insertItems(at: [indexPath])
        }, completion: nil)
    }
    
    func removeIndexFromBasket(_ indexPath: IndexPath) {
        basketCollection.performBatchUpdates({
            self.basketCollection.deleteItems(at: [indexPath])
        }, completion: nil)
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
        
        if to >= 1 && to <= 2 && itemsInListLabel.alpha == 0 {
            UIView.animate(withDuration: 0.6) {
                self.itemsInListLabel.alpha = 1
            }
        }
        else if (to == 0 || to > 2) && itemsInListLabel.alpha == 1 {
            UIView.animate(withDuration: 0.6) {
                self.itemsInListLabel.alpha = 0
            }
        }
    }
    
    // MARK: - Connect to Selection of Pack
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainStoryboard.Segue.toSelectPack {
            let dest = segue.destination as! SelectPackViewController
            dest.delegate = self
        }
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
