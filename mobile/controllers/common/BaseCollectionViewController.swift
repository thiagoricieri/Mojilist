//
//  BaseCollectionViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionViewController: BaseViewController,
        UICollectionViewDelegate,
        UICollectionViewDataSource {
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        theme.background(collection)
    }
    
    // MARK: - View Rendering
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = baseViewModel as? BaseDataViewModel {
            viewModel.loadSource()
            reload()
        }
    }
    
    // MARK: - Collection Delegate
    
    func reload() {
        collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if let viewModel = baseViewModel as? BaseDataViewModel {
            return viewModel.itemsCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        if let c = cell as? BaseEmojiCell {
            c.applyTheme(baseViewModel.theme)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
