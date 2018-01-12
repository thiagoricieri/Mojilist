//
//  BaseTableViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

protocol BaseTableView: BaseView {
}

class BaseTableViewController: BaseViewController,
        BaseTableView,
        UITableViewDelegate,
        UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let dataPresenter = basePresenter as? BaseDataPresenter {
            dataPresenter.loadSource()
            dataPresenter.downloadSource()
            reload()
        }
    }
    
    // MARK: - Convenience
    func reload() {
        table.reloadData()
    }
    
    // MARK: - Table Delegate
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if let dataPresenter = basePresenter as? BaseDataPresenter {
            return dataPresenter.sourceCount()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return BaseTableViewCell()
    }
}
