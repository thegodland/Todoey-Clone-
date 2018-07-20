//
//  Item.swift
//  Todoey
//
//  Created by 刘祥 on 7/19/18.
//  Copyright © 2018 Orange Arrow. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var createdDate : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

