//
//  Extensions.swift
//  FirstRealmTest
//
//  Created by Lukáš Spurný on 04/07/2019.
//  Copyright © 2019 sikisoft.cz. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func presentAlert(title: String?, message: String, actions: UIAlertAction..., animated: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: animated, completion: nil)
    }
    
    func presentActionSheet(title: String?, message: String, actions: UIAlertAction..., animated: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: animated, completion: nil)
    }
    
    
    
//    MARK: EXAMPLE FOR ALERT
    
    
//    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { _ in
//
//    })
    
//    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    
//    let enter = UIAlertAction(title: "OK", style: .destructive, handler: { _ in
//
//    })
//
//    presentAlert(title: "myStartTitle", message: "Very important message", actions: enter, cancel)
    
    
}
