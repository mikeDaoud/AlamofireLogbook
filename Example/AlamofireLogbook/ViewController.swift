//
//  ViewController.swift
//  AlamofireLogbook
//
//  Created by mikeAttia on 06/01/2018.
//  Copyright (c) 2018 mikeAttia. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireLogbook

class ViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        activityIndicator.color = UIColor.gray
        view.addSubview(activityIndicator)
    }
    
    @IBAction private func callSample(_ sender: Any) {
        call(api: "https://www.googleapis.com/books/v1/volumes?q=isbn:0747532699")
    }
    
    @IBOutlet private weak var urlField: UITextField!
    
    @IBAction private func callApi(_ sender: Any) {
        if let api = urlField.text{
            call(api: api)
        }
    }
    
    @IBAction private func showLogs(_ sender: Any) {
        AlamofireLogbook.show()
    }
    
    private func call(api: String){
        activityIndicator.startAnimating()
        let req = Alamofire.request(api).log()
        req.responseJSON{ response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(response.result)")
            self.activityIndicator.stopAnimating()
        }
    }
    
}

