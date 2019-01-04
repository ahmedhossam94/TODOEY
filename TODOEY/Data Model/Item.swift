//
//  Item.swift
//  TODOEY
//
//  Created by ahmed on 1/3/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parenCategory = LinkingObjects(fromType: Category.self, property: "items")
}
