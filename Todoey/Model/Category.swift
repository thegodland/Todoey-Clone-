//
//  Category.swift
//  Todoey
//
//  Created by 刘祥 on 7/19/18.
//  Copyright © 2018 Orange Arrow. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    @objc dynamic var backgroundColor : String = ""
}
