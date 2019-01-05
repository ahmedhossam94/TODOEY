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
    @objc dynamic var colorString : String = ""
    let items = List<Item>()
}


