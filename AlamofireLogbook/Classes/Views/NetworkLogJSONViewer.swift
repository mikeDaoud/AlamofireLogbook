//
//  NetworkLogJSONViewer.swift
//  AlamofireLogbook
//
//  Created by Michael Attia on 3/23/18.
//  Copyright © 2018 TSSE. All rights reserved.
//

import UIKit

class NetworkLogJSONViewer: UIViewController, UISearchBarDelegate {
    
    var data: Data?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = self.data, let dataToView = String(data: data, encoding: .utf8){
            textView.text = dataToView
        }else{
            textView.text = "null"
        }
    }
}
