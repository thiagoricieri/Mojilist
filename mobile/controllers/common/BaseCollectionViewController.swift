//
//  BaseCollectionViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 11/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCollectionView: BaseView {
}

class BaseCollectionViewController: BaseViewController,
        BaseCollectionView,
        UICollectionViewDelegate,
        UICollectionViewDataSource {
    
    // Outlets
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let dataPresenter = basePresenter as? BaseDataPresenter {
            dataPresenter.loadSource()
            dataPresenter.downloadSource()
        }
    }
    
    // MARK: - Convenience
    func reload() {
        collection.reloadData()
    }
    
    // MARK: - Collection Delegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if let dataPresenter = basePresenter as? BaseDataPresenter {
            return dataPresenter.sourceCount()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
