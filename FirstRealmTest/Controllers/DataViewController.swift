//
//  DataViewController.swift
//  FirstRealmTest
//
//  Created by Lukáš Spurný on 19/04/2019.
//  Copyright © 2019 sikisoft.cz. All rights reserved.
//

import UIKit
import RealmSwift

class DataViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))

    }
    

    @objc func backAction(){
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension DataViewController: UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(Data.self).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataTableViewCell", for: indexPath) as! DataTableViewCell
        let realm = try! Realm()
        let results = realm.objects(Data.self)
        
        cell.idLabel.text = String(results[indexPath.row].id)
        cell.nameLabel.text = results[indexPath.row].name
        cell.surnameLabel.text = results[indexPath.row].surname
        cell.ageLabel.text = results[indexPath.row].age
        cell.createLabel.text = results[indexPath.row].created_at
        return cell
    }
    
    // MARK: check ID
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: PREPARE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSingleData" {
//            print(self.tableView.indexPathForSelectedRow?.row)
            let updateViewController:DataDetailViewController = segue.destination as! DataDetailViewController
            let realm = try! Realm()
            updateViewController.dataDetail = realm.objects(Data.self)[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
}
