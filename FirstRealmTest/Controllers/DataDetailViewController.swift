//
//  DataDetailViewController.swift
//  FirstRealmTest
//
//  Created by Lukáš Spurný on 21/04/2019.
//  Copyright © 2019 sikisoft.cz. All rights reserved.
//

import UIKit
import RealmSwift
import SideMenu

class DataDetailViewController: UIViewController{
    
    var dataDetail:Data?
    
    let customSideMenuManager = SideMenuManager()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var createdAtTextField: UITextField!
    
    @IBOutlet weak var detailData: UILabel!
    
    @IBAction func editActionButton(_ sender: Any) {
        
        let cancel = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        let enter = UIAlertAction(title: "YES", style: .destructive, handler: { _ in
            if let editId:Int = self.dataDetail?.id {
                let realm = try! Realm()
                let myUpdateData = realm.objects(Data.self).filter("id == %@", editId).first
                try! realm.write {
                    myUpdateData!.name = self.nameTextField.text!
                    myUpdateData!.surname = self.surnameTextField.text!
                    myUpdateData!.age = self.ageTextField.text!
                    
            
                    let cancel = UIAlertAction(title: "OK", style: .default, handler: nil)
                    self.presentAlert(title: "Edit complete", message: "data \(editId) is update", actions: cancel)
                    
                }
            }
        })
        
        presentAlert(title: "Edit item?", message: "Really edit \(String(describing: self.idTextField.text!)) item?", actions: enter, cancel)
        
    }
    
    @IBAction func deleteActionButton(_ sender: Any) {
        
        let cancel = UIAlertAction(title: "NO", style: .cancel, handler: nil)
    
        let enter = UIAlertAction(title: "YES", style: .destructive, handler: { _ in
            
            if let editId:Int = self.dataDetail?.id {
                let realm = try! Realm()
                let myUpdateData = realm.objects(Data.self).filter("id == %@", editId).first
                try! realm.write {
                    realm.delete(myUpdateData!)
                    
                    let cancel = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.performSegue(withIdentifier: "redirect", sender: self)
                    })
                    self.presentAlert(title: "Delete item", message: "Item \(editId) is delete", actions: cancel)
                    
                }
            }
            
        })
    
        presentAlert(title: "Delete item?", message: "Really delete \(String(describing: self.idTextField.text!)) item?", actions: enter, cancel)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("self.dataDetail!")
        print(self.dataDetail!)
        if let myDataDetail = self.dataDetail {

            self.detailData.text = "DETAIL DATA ID: \(String(myDataDetail.id))"
            self.idTextField.text = String(myDataDetail.id)
            self.nameTextField.text = myDataDetail.name!
            self.surnameTextField.text = myDataDetail.surname!
            self.ageTextField.text = myDataDetail.age!
            self.createdAtTextField.text = myDataDetail.created_at!
        }
        
//        self.idTextField.delegate = self
//        self.nameTextField.delegate = self
//        self.surnameTextField.delegate = self
//        self.ageTextField.delegate = self
//        self.createdAtTextField.delegate = self
        
        self.idTextField.isEnabled = false
        self.createdAtTextField.isEnabled = false
        
//        sideMenuManager = customSideMenuManager
    }
 
}

extension DataDetailViewController:  UITextFieldDelegate {
    
    
    // MARK: - show keyboard on enter click
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.idTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.surnameTextField.resignFirstResponder()
        self.ageTextField.resignFirstResponder()
        self.createdAtTextField.resignFirstResponder()
        return true
    }
    

}
