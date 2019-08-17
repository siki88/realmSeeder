//
//  ViewController.swift
//  FirstRealmTest
//
//  Created by Lukáš Spurný on 19/04/2019.
//  Copyright © 2019 sikisoft.cz. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift

class ViewController: UIViewController {
    
    //MARK: StopVatch attribute
    var start = Date()
    var stopped : Date?
    var resumed : Date?
    var finished : Date?
    
    var timer : Timer?
    
    var timeElapsed = Double()
    var timeStopped = Double()
    
    
    
    let myDateFormat:String = "dd-MM-yyy HH:mm:ss"
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var secondNameLabel: UITextField!
    @IBOutlet weak var theertyNameLabel: UITextField!
    @IBOutlet weak var fourtyNameLabel: UITextField!
    @IBOutlet weak var coundSeed: UITextField!
    @IBOutlet weak var countData: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: Any) {
        
        self.activityIndicator.startAnimating()
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
            self.activityIndicator.stopAnimating()
            
        })
        let enter = UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            let realm = try! Realm()
            let result = (realm.objects(Data.self).max(ofProperty: "id") as Int? ?? 0) + 1
            let myData = Data()
            myData.id = result
            myData.name = self.firstNameLabel.text!
            myData.surname = self.secondNameLabel.text!
            myData.age = self.theertyNameLabel.text!
            myData.created_at = self.fourtyNameLabel.text!
            try! realm.write {
                realm.add(myData)
                let countRealmData = String(realm.objects(Data.self).count)
                self.countData.text = "count: \(countRealmData)"
                self.activityIndicator.stopAnimating()
            }
            
        })
        presentAlert(title: "save item?", message: "", actions: enter, cancel)
    }
    
    @IBAction func deleteFile(_ sender: Any) {
        
        self.activityIndicator.startAnimating()
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.activityIndicator.stopAnimating()
        })
        let enter = UIAlertAction(title: "Delete", style: .default, handler: { _ in
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
                let countRealmData = String(realm.objects(Data.self).count)
                self.countData.text = "count: \(countRealmData)"
                self.activityIndicator.stopAnimating()
            }
        })
    
        presentAlert(title: "Delete file?", message: "", actions: enter, cancel)
        
    }
    
    @IBAction func seedRealmData(_ sender: Any) {
        
        if let count = self.coundSeed.text, count != ""{
            
            self.activityIndicator.startAnimating()
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                self.activityIndicator.stopAnimating()
            })
            let enter = UIAlertAction(title: "Start", style: .default, handler: { _ in
                
                let realm = try! Realm()
                
                let myCount:Int = Int(count)!
                for number in 1...myCount {
                    let result = (realm.objects(Data.self).max(ofProperty: "id") as Int? ?? 0) + 1
                    let myData = Data()
                    let myNumber:String = String(number)
                    myData.id = result
                    myData.name = "test-\(myNumber)-1"
                    myData.surname = "test-\(myNumber)-2"
                    myData.age = "test-\(myNumber)-3"
                    myData.created_at = "\(self.actualDateFormatted(outputForm: self.myDateFormat))"
                    try! realm.write {
                        realm.add(myData)
                    }
                }
                let countRealmData = String(realm.objects(Data.self).count)
                self.countData.text = "count: \(countRealmData)"
                
                    let enter = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.activityIndicator.stopAnimating()
                        self.coundSeed.text = ""
                    })
                
                    self.presentAlert(title: "Seed complete", message: "\(count) is seed", actions: enter)
                
            })
        
            presentAlert(title: "Seed items?", message: "Really seed \(count) items?", actions: enter, cancel)
            
        }else{
            alertAction(title: "Is not define number seed", message: "write the number")
        }
            
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        let myCount = String(realm.objects(Data.self).count)
        self.countData.text = "count: \(myCount)"
        
        self.fourtyNameLabel.text = actualDateFormatted(outputForm: myDateFormat)
        self.fourtyNameLabel.isEnabled = false
        
        myActivityIndicator()
        addDoneButtonOnKeyboard()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func myActivityIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = UIColor(red: 63/255, green: 149/255, blue: 247/255, alpha: 1)
        view.addSubview(activityIndicator)
    }
    
    func alertAction(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: CONVERT Actual Date formated
    func actualDateFormatted(outputForm:String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = outputForm
        let result = formatter.string(from: date)
        return result
    }
    
    // MARK: CONVERT Date formated
    func universalConvertDateFormater(date:String,inputFormate:String,outputFormate:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormate
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = outputFormate
        return  dateFormatter.string(from: date!)
    }
    
    // MARK: ADD DONE BUTTON KEYBOARD
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        coundSeed.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        coundSeed.resignFirstResponder()
    }


}

extension ViewController:  UITextFieldDelegate {
    
    // MARK: - show keyboard on enter click
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.firstNameLabel.resignFirstResponder()
        self.secondNameLabel.resignFirstResponder()
        self.theertyNameLabel.resignFirstResponder()
        self.fourtyNameLabel.resignFirstResponder()
        self.coundSeed.resignFirstResponder()
        return true
    }
    
}
