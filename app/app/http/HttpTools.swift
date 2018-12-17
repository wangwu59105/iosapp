//
//  HttpTools.swift
//  app
//
//  Created by Apple on 2018/11/21.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit
import Alamofire

class HttpTools: NSObject {

    
    /// 点击首页加号按钮，获取频道推荐数据
    class func login(_ phone  :String ,_ password : String,
                            completionHandler:@escaping (BaseVO<User>) -> Void,
                            errorHandler:@escaping (_ errorMessge: String) -> Void) {
        
        var parameters = getParameters();
        parameters["loginMode"] = "0"
        parameters["userName"] = phone
        parameters["pswd"] = password.ts_MD5String
        TSProgressHUD.ts_showWithStatus("登录")
        required(p: parameters, m: USER_LOGIN) { response in
            TSProgressHUD.ts_dismiss()
            switch response.result {
            case .success:
                if let base = BaseVO<User>.deserialize(from: response.result.value ?? ""){
                    completionHandler(base)
                }
            case .failure(let error):
                errorHandler(error.localizedDescription)
            }
           
        }        
    }
}
