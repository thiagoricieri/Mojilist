//
//  ShareStudioViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 14/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ShareSnippetView: UIView,
        UICollectionViewDelegate,
        UICollectionViewDataSource {
    
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var creditsName: UILabel!
    @IBOutlet weak var creditsUrl: UILabel!
    
    var list: REmojiList?
    
    var maxWidth = 686
    var maxHeight = 514
    let margin = 8
    var itemSize = 0
    
    override func awakeFromNib() {
        let nib = UINib(nibName: ShareCell.identifier, bundle: nil)
        
        collection.register(nib, forCellWithReuseIdentifier: ShareCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        
        let del = UIApplication.shared.delegate as! AppDelegate
        applyTheme(del.app.theme)
    }
    
    func applyTheme(_ theme: Theme) {
        theme.primaryText(listName)
        theme.secondaryText(creditsName)
        theme.secondaryText(creditsUrl)
        theme.background(self)
        theme.background(collection)
    }
    
    func configure(with emojiList: REmojiList) {
        list = emojiList
        
        creditsName.text = "Share.Credits1".localized
        creditsUrl.text = "Share.Credits2".localized
        listName.text = list?.name
        
        maxWidth = Int(collection.bounds.width)
        maxHeight = Int(collection.bounds.height)
        
        itemSize = recalculateBasedOnItems(list!.emojis) - margin
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        collection.reloadData()
    }
    
    func recalculateBasedOnItems(_ emojis: List<REmoji>) -> Int {
        let minSize = 50
        let maxSize = 220
        
        let maxItemsMinSize = itemsToFit(
            inWidth: maxWidth, inHeight: maxHeight,
            withMargin: margin, withSize: minSize)
        
        let maxItemsMaxSize = itemsToFit(
            inWidth: maxWidth, inHeight: maxHeight,
            withMargin: margin, withSize: maxSize)
        
        if emojis.count >= maxItemsMinSize.2 {
            return minSize
        }
        
        if emojis.count <= maxItemsMaxSize.2 {
            return maxSize
        }
        
        for i in minSize...maxSize {
            let dynamicSize = itemsToFit(
                inWidth: maxWidth, inHeight: maxHeight,
                withMargin: margin, withSize: i)
            
            if emojis.count > dynamicSize.2 {
                return i
            }
        }
        
        // Never used
        return maxSize
    }
    
    func itemsToFit(inWidth: Int, inHeight: Int, withMargin: Int, withSize: Int) -> (Int, Int, Int) {
        let rows = (inHeight - withMargin) / withSize
        let columns = (inWidth - withMargin * 2) / withSize
        return (columns, rows, columns * rows)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list != nil ? list!.emojis.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShareCell.identifier,
            for: indexPath) as! ShareCell
        let del = UIApplication.shared.delegate as! AppDelegate
        
        if let item = list?.emojis[indexPath.row] {
            cell.configure(with: item, squareSize: itemSize)
            cell.applyTheme(del.app.theme)
        }
        
        return cell
    }
}

class ShareCell: UICollectionViewCell {
    
    static let identifier = "ShareCell"
    
    @IBOutlet weak var emojiView: EmojiDropView!
    
    override func awakeFromNib() {
        clipsToBounds = false
    }
    
    func configure(with emoji: REmoji, squareSize: Int) {
        emojiView.configure(with: emoji)
        emojiView.resize(square: squareSize)
    }
    
    func applyTheme(_ theme: Theme) {
        emojiView.applyTheme(theme)
    }
}
