//
//  UIApplication+topViewController.swift
//  AlamofireLogbook
//
//  Created by Michael Attia on 6/1/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import Foundation

extension UIApplication {
    
    class func topVC(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topVC(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topVC(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topVC(presented)
        }
        return base
    }
}
