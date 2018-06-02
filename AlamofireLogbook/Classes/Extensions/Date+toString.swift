//
//  Date+toString.swift
//  AlamofireLogbook
//
//  Created by Michael Attia on 6/1/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import Foundation

extension Date{
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


