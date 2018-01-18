//
//  WebViewController.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 18/01/2018.
//  Copyright © 2018 Ghost Ship. All rights reserved.
//

import Foundation
import WebKit

class WebViewController: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url = ""
    
    override func prepareViewForUser() {
        super.prepareViewForUser()
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    @IBAction func actionSafari(sender: Any) {
        let myURL = URL(string: url)
        UIApplication.shared.open(myURL!, options: [:], completionHandler: nil)
        navigationController?.popViewController(animated: true)
    }
}
