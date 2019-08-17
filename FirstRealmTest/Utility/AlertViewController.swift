//
//  AlertViewController.swift
//  FirstRealmTest
//
//  Created by Lukáš Spurný on 04/05/2019.
//  Copyright © 2019 sikisoft.cz. All rights reserved.
//

import UIKit

class AlertViewController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
//            UIAlertAction.init(title: "Hello", style: .default, handler: nil)
        // Do any additional setup after loading the view.
    }
    

    public func getAlert(title:String,message:String){
        let alert = UIAlertController(title: "OK", message: "delete all data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
