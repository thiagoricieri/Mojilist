//
//  ShareStudioViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 14/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class ShareSnippetView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var itemsContainer: UIView!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var creditsName: UILabel!
    @IBOutlet weak var creditsUrl: UILabel!
    
    var list: REmojiList?
    
    let maxWidth = 686
    let maxHeight = 514
    let margin = 8
    
    override func awakeFromNib() {
        let nib = UINib(nibName: ShareCell.identifier, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: ShareCell.identifier)
        collection.delegate = self
        collection.dataSource = self
    }
    
    func configure(with emojiList: REmojiList) {
        list = emojiList
        
        creditsName.text = "Share.Credits1".localized
        creditsUrl.text = "Share.Credits2".localized
        listName.text = list?.name
        
        collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list != nil ? list!.emojis.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShareCell.identifier,
            for: indexPath) as! ShareCell
        
        if let item = list?.emojis[indexPath.row] {
            cell.configure(with: item)
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
    
    func configure(with emoji: REmoji) {
        emojiView.configure(with: emoji)
    }
}
