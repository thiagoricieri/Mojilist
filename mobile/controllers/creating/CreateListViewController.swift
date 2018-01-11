//
//  CreateListViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import UIKit

protocol CreateListView: BaseView {
}

class CreateListViewController: BaseViewController, CreateListView {
    
    @IBOutlet weak var listNameField: UITextField!
    
    var presenter: CreateListPresenter!
    
    override func instantiateDependencies() {
        presenter = CreateListPresenterImpl(view: self)
    }
    
    override func setViewStyle() {
        title = "CreateList.Title".localized
    }
    
    override func prepareViewForUser() {
        listNameField.becomeFirstResponder()
    }
    
    deinit {
        presenter.unload()
        presenter = nil
    }
}

// MARK: - Text Field Delegate
extension CreateListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
