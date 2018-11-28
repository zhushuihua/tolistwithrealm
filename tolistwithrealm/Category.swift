//
//  Category.swift
//  tolistwithrealm
//
//  Created by Shuihua Zhu on 28/11/18.
//  Copyright © 2018 UMA Mental Arithmetic. All rights reserved.
//

import Foundation
import RealmSwift
class Category:Object{
    @objc dynamic var name:String = ""
    @objc dynamic var time:Date = Date()
    let items:List<Item> = List<Item>()
}
