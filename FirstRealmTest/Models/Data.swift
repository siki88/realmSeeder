//
//  Data.swift
//  FirstRealmTest
//
//  Created by Lukáš Spurný on 19/04/2019.
//  Copyright © 2019 sikisoft.cz. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var surname: String?
    @objc dynamic var age: String?
    @objc dynamic var created_at: String?


}

//class Dog: Object {
//    @objc dynamic var name = ""
//    @objc dynamic var age = 0
//}

//class Data: NSObject {
//    let id: String
//    let name: String
//    let surname: String
//    let age: String
//    let created_at: String
//
//    init(id: String, name: String, surname: String, age: String, created_at: String ) {
//        self.id = id
//        self.name = name
//        self.surname = surname
//        self.age = age
//        self.created_at = created_at
//    }
//}


