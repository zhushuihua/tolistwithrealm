//
//  Item.swift
//  tolistwithrealm
//
//  Created by Shuihua Zhu on 28/11/18.
//  Copyright © 2018 UMA Mental Arithmetic. All rights reserved.
//

import Foundation
import RealmSwift
class Item:Object{
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var time = Date()
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
