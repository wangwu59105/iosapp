//
//  ListPageVO.swift
//  app
//
//  Created by Apple on 2018/11/15.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit
import HandyJSON

class ListPageVO<Element> : HandyJSON {
    required init() {
        
    }
    var currentPage : Int?
    var hasNextPage :Bool? = false
    var pages : Int?
    var rows : [Element]?
}
