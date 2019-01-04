//
//  Category.swift
//  TODOEY
//
//  Created by ahmed on 1/3/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}


