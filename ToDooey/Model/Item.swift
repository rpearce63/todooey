//
//  Item.swift
//  ToDooey
//
//  Created by Rick Pearce on 4/23/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
