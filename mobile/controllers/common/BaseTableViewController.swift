//
//  BaseTableViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 10/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController: BaseViewController,
        UITableViewDelegate,
        UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        theme.background(table)
    }
    
    // MARK: - View Rendering
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = baseViewModel as? BaseDataViewModel {
            viewModel.loadSource()
            reload()
        }
    }
    
    // MARK: - Table Delegate
    func reload() {
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if let viewModel = baseViewModel as? BaseDataViewModel {
            return viewModel.itemsCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if let c = cell as? BaseTableViewCell {
            c.applyTheme(baseViewModel.theme)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return BaseTableViewCell()
    }
}
