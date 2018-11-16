//
//  User.swift
//  app
//
//  Created by Apple on 2018/11/15.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit
import Cache
import HandyJSON
class User:HandyJSON {
    static let key = "user.key"
    required init() {
    }
    var id: Int?
    var firstName: String?
    var lastName: String?
    var url: String?
}
