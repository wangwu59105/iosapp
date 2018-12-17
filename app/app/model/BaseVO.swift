//
//  BaseVO.swift
//  app
//
//  Created by Apple on 2018/11/15.
//  Copyright © 2018年 wangwu. All rights reserved.
//
import UIKit
import HandyJSON

class BaseVO<Element> : HandyJSON {
    required init() {
        
    }
    var code : String?
    var isSuccess :Bool{
        get{
            return code=="1"
        }
    }
    var msg : String?
    var data : Element?
}
