//
//  Category.swift
//  ToDoList
//
//  Created by Bilal on 2018-03-15.
//  Copyright © 2018 Bilal Kamal Co. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let items = List<Item>()
    
}
