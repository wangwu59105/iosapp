//
//  HttpConfig.swift
//  app
//
//  Created by Apple on 2018/11/21.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import Foundation
import Alamofire


let  SERVER_SIT = "https://192.168.20.64:8446"
let  SERVER_REALES = "https://www.kadi56.net:844"



public let USER_LOGIN = "/login/checkLogin"//登录
public let USRACCOUNT_LIST = "/usrAccount/list"//账户管理



public func GetURL(method :String)->String{
    
    #if DEBUG
     return SERVER_SIT + method;
    #else
     return SERVER_REALES + method;
    #endif
    
}

public func getParameters() -> netParameter{
    return  [String : String]()
}

///设置跳过https证书
public func required(p parameters : [String : String]? =  getParameters(),m method : String, completionHandler: @escaping (DataResponse<String>) -> Void ) -> DataRequest {
    let sign = GetSign(dictionary: parameters!)
    var parameters = parameters;
    parameters!["_sign"] = sign
    parameters!["_key"] = MAP_KEY
    
    let url = GetURL(method: method)
    let headers = GetHeader()
    let manager = SessionManager.default
    manager.delegate.sessionDidReceiveChallenge = { session,challenge in return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!)) } //默认都为允许访问 不鉴权
    let  request = Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers);
    request.responseString { response in
        //可以统一拦截错误编码
        if let res = response.response {
            let headers = res.allHeaderFields
            if(headers.count>0){
                if let token :String = headers[AnyHashable("token")] as? String{
                     SpSimpleDefulat.setToken(token)
                }
               
            }
        }
        completionHandler(response)
    }
    return request
}




public func GetHeader() -> HTTPHeaders{
    let token = SpSimpleDefulat.getToken()
    let header : [String: String] = [
        "appKey": UIDevice.current.identifierForVendor?.uuidString ?? "",
        "token":token]
    return header;
}


public func GetSign(dictionary :[String : String])->String{
    var sb = String();
    if(!dictionary.isEmpty){
        //排序签名
        let ks = dictionary.keys
        let nks = ks.sorted()
        for key in nks{
            sb.append(key);
            let value = dictionary[key]
            if(nil != value){
                let valueUtf8 = value!.utf8encodedString()
                sb.append(valueUtf8);
            }
        }
    }
    return (SIGN_KEY +  sb + SIGN_KEY).ts_MD5String 
}
