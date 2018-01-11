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
}

class SelectEmojisViewController: BaseCollectionViewController, SelectEmojisView {
    
    var listName: String!
    var presenter: SelectEmojisPresenter!
    
    @IBOutlet weak var animationContainer: UIView!
    @IBOutlet weak var createButton: UIButton!
    
    override func instantiateDependencies() {
        basePresenter = SelectEmojisPresenterImpl(view: self)
        presenter = basePresenter as! SelectEmojisPresenter
    }
    
    override func setViewStyle() {
        title = "SelectEmojis.Title".localized
        createButton.setTitle("SelectEmojis.Create".localized, for: .normal)
        createButton.setTitle("SelectEmojis.Create".localized, for: .disabled)
    }
    
    override func prepareViewForUser() {
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
}
