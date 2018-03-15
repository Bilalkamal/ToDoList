//
//  Item.swift
//  ToDoList
//
//  Created by Bilal on 2018-03-15.
//  Copyright © 2018 Bilal Kamal Co. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self , property: "items")
    
}
