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

class SelectEmojisViewController: BaseCollectionViewController,
        SelectEmojisView,
        SelectPackDelegate {
    
    var listName: String!
    var presenter: SelectEmojisPresenter!
    
    @IBOutlet weak var animationContainer: UIView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var selectedPackButton: UIButton!
    
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
    }
    
    override func prepareViewForUser() {
        reload()
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
    @IBAction func actionCreate(sender: UIView) {
        
    }
    
    @IBAction func actionSelectedPack(sender: UIView) {
        performSegue(withIdentifier: MainStoryboard.Segue.toSelectPack, sender: nil)
    }
}
