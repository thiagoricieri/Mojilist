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
    
    var presenter: BaseTablePresenter!
    
    // Outlets
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadSource()
        presenter.downloadSource()
    }
    
    // MARK: - Convenience
    func reload() {
        table.reloadData()
    }
    
    // MARK: - Table Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sourceCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return BaseTableViewCell()
    }
    
    // MARK: - Base View
    deinit {
        presenter.unload()
        presenter = nil
    }
}
