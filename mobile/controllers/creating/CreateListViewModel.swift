//
//  CreateListViewModel.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 20/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation

class CreateListViewModel: BaseViewModel {
    
    func validateInput(listName: String?) -> Bool {
        return listName != nil && !listName!.isEmpty
    }
}
