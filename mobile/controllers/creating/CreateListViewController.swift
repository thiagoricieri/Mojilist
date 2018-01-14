//
//  CreateListViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import UIKit

protocol CreateListView: BaseView {
    
    func goToSelectEmojis()
}

class CreateListViewController: BaseViewController, CreateListView {
    
    @IBOutlet weak var listNameField: UITextField!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    
    var presenter: CreateListPresenter!
    
    override func instantiateDependencies() {
        basePresenter = CreateListPresenterImpl(view: self)
        presenter = basePresenter as! CreateListPresenter
    }
    
    override func setViewStyle() {
        title = "CreateList.Title".localized
        listNameField.placeholder = "CreateList.Text.Placeholder".localized
        listNameLabel.text = "CreateList.Label".localized
        hintLabel.text = "CreateList.Hint".localized
        nextBarButton.title = "CreateList.Next".localized
    }
    
    override func prepareViewForUser() {
        listNameField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainStoryboard.Segue.toSelectEmojis {
            let dest = segue.destination as! SelectEmojisViewController
            dest.listName = listNameField.text
        }
    }
    
    func goToSelectEmojis() {
        performSegue(withIdentifier: MainStoryboard.Segue.toSelectEmojis, sender: nil)
    }
    
    @IBAction func actionNext(sender: Any?) {
        if presenter.validateInput(listName: listNameField.text) {
            goToSelectEmojis()
        }
    }
}

// MARK: - Text Field Delegate
extension CreateListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        actionNext(sender: nil)
        return true
    }
}
