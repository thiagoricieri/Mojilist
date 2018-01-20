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

class SelectEmojisViewController: BaseCollectionViewController,
        SelectPackDelegate {
    
    var viewModel: SelectEmojisViewModel!
    var passListViewModel: EmojiListViewModel!
    
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
        baseViewModel = SelectEmojisViewModel(listViewModel: passListViewModel)
        viewModel = baseViewModel as! SelectEmojisViewModel
    }
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        theme.separator(separator)
        theme.background(basketCollection)
        theme.actionButton(createButton)
        theme.badge(badgeView)
        theme.secondaryText(itemsInListLabel)
        
        topFadeDecoration.image = UIImage(named: theme.topDecoration())
        bottomFadeDecoration.image = UIImage(named: theme.bottomDecoration())
        indicatorDecoration.image = UIImage(named: theme.indicatorDecoration())
    }
    
    override func setViewStyle() {
        title = viewModel.listName
        createButton.setTitle("SelectEmojis.Create".localized, for: .normal)
        createButton.setTitle("SelectEmojis.Create".localized, for: .disabled)
        clearBarItem.title = "SelectEmojis.Clear".localized
        itemsInListLabel.text = "SelectEmojis.ItemsInList".localized
        badgeView.layer.cornerRadius = badgeView.bounds.width/2
        badgeView.clipsToBounds = true
    }
    
    override func reload() {
        super.reload()
        selectedPackButton.setTitle(viewModel.localizedPackName, for: .normal)
    }
    
    // MARK: - Collection View Boilerplate
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let emoji: EmojiPackItemViewModel!
        
        if collectionView == collection {
            emoji = viewModel.item(at: indexPath)
        } else {
            emoji = viewModel.item(selectedAt: indexPath)
        }
        
        if !emoji.hasImage {
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
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if collectionView == collection {
            viewModel.select(emojiAt: indexPath)
            
            if let cell = collectionView.cellForItem(at: indexPath) as? BaseEmojiCell {
                cell.springView.animation = "pop"
                cell.springView.curve = "easeOut"
                cell.springView.duration = 0.5
                cell.springView.animate()
            }
            
            lightImpact()
            updateBasket()
            addIndexToBasked(IndexPath(item: 0, section: 0))
        }
        else {
            viewModel.remove(emojiAt: indexPath)
            updateBasket()
            lightImpact()
            removeIndexFromBasket(indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection {
            return viewModel.itemsCount
        } else {
            return viewModel.selectedCount
        }
    }
    
    // MARK: - Pack Selection Delegate
    
    func packSelected(pack: EmojiPackViewModel) {
        viewModel.source = pack
        navigationController?.popViewController(animated: true)
        reload()
    }
    
    func selectedPack() -> EmojiPackViewModel {
        return viewModel.source
    }
    
    // MARK: - Handle Basket
    
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
    
    func updateBasket() {
        let count = viewModel.selectedCount!
        
        if count > 0 {
            badgeView.isHidden = false
            createButton.isEnabled = true
            badgeCountLabel.text = viewModel.selectedCountText
            badgeView.animation = "pop"
            badgeView.curve = "easeInOut"
            badgeView.animate()
        } else {
            badgeView.isHidden = true
            createButton.isEnabled = false
        }
        
        if count >= 1 && count <= 2 && itemsInListLabel.alpha == 0 {
            UIView.animate(withDuration: 0.6) {
                self.itemsInListLabel.alpha = 1
            }
        }
        else if (count == 0 || count > 2) && itemsInListLabel.alpha == 1 {
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
        viewModel.createList()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func actionSelectedPack(sender: Any) {
        performSegue(withIdentifier: MainStoryboard.Segue.toSelectPack, sender: nil)
    }
    
    @IBAction func actionClear(_ sender: Any) {
        var allIndexes = [IndexPath]()
        for i in 0...viewModel.selectedCount - 1 {
            allIndexes.append(IndexPath(item: i, section: 0))
        }
        
        viewModel.clearList()
        updateBasket()
        
        basketCollection.performBatchUpdates({
            self.basketCollection.deleteItems(at: allIndexes)
        }, completion: nil)
    }
}
