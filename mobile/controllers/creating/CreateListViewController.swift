//
//  CreateListViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 09/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import UIKit
import Saw

class CreateListViewController: BaseViewController {
    
    @IBOutlet weak var listNameField: UITextField!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    
    var viewModel: CreateListViewModel!
    var passListViewModel: EmojiListViewModel?
    
    override func instantiateDependencies() {
        baseViewModel = CreateListViewModel()
        viewModel = baseViewModel as! CreateListViewModel
    }
    
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        theme.darkBackground(listNameField)
        theme.primaryText(listNameLabel)
        theme.primaryText(listNameField)
        theme.secondaryText(hintLabel)
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
        if let listVM = passListViewModel {
            listNameField.text = listVM.name
        }
        navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainStoryboard.Segue.toSelectEmojis {
            let dest = segue.destination as! SelectEmojisViewController
            
            if let listVM = passListViewModel {
                listVM.pendingName = listNameField.text!
                dest.passListViewModel = listVM
            } else {
                dest.passListViewModel = EmojiListViewModel(named: listNameField.text!)
            }
        }
    }
    
    @IBAction func actionNext(sender: Any?) {
        if viewModel.validateInput(listName: listNameField.text) {
            goToSelectEmojis()
        }
    }
    
    func goToSelectEmojis() {
        performSegue(withIdentifier: MainStoryboard.Segue.toSelectEmojis, sender: nil)
    }
}

// MARK: - Text Field Delegate
extension CreateListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        actionNext(sender: nil)
        return true
    }
}
