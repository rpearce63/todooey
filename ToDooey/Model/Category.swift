//
//  Category.swift
//  ToDooey
//
//  Created by Rick Pearce on 4/23/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundColor: String = ""
    let items = List<Item>()
}
