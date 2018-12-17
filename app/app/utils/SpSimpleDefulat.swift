//
//  SpSimpleDefulat.swift
//  app
//
//  Created by Apple on 2018/11/21.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class SpSimpleDefulat: NSObject {

    static let sp = UserDefaults.standard
    
    static func setToken(_ token : String)  {
        sp.set(token, forKey: S_TOKEN_KEY)
    }
    
    static func getToken() -> String {
        return sp.string(forKey: S_TOKEN_KEY) ?? ""
    }
}
