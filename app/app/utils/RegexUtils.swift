//
//  RegexUtils.swift
//  kdlogistics
//
//  Created by Apple on 2017/10/25.
//  Copyright © 2017年 wangwu. All rights reserved.
//

import Foundation

class RegexUtils {
    
    // public static final String MATCHESM4D3="(^\\d{5,}(\\.\\d+)?$)||(^\\d{1,4}(\\.\\d{4,})$)";//限制四位整数或三位小数
    
    
    //public static final String MATCHESM0D000="(^0{2,}(\\.\\d+)?$)||(^0\\.000$)";//0.000无效

    
    static func isRegex(_ regexString : String, regex : String) -> Bool {
        if(!regexString.isEmpty && !regex.isEmpty){
            let matcher = MyRegex(regex)
            let m =  matcher.match(input: regexString)
            return m
        }
        
        return false
       
    }
    
    static func isWeight4D3(weight : String) -> Bool {
        if(weight.isEmpty){
            return false
        }
        let mailPattern = "^\\d{1,4}(\\.\\d{1,3})?$"
        let matcher = MyRegex(mailPattern)
        return matcher.match(input: weight)
    }
    
    
    
    static func isEmail(emailStr : String) -> Bool {
        if(emailStr.isEmpty){
            return false
        }
        let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let matcher = MyRegex(mailPattern)
        return matcher.match(input: emailStr)
    }
    
    static func isPhone(phoneStr : String) -> Bool {
        if(phoneStr.isEmpty){
            return false
        }
        let mailPattern = "^1[0-9]{10}$"
        let matcher = MyRegex(mailPattern)
        return matcher.match(input: phoneStr)
    }
    
    static func isCarNum(carNumStr : String) -> Bool {
        if(carNumStr.isEmpty){
            return false
        }
        let mailPattern = "^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$"
        let matcher = MyRegex(mailPattern)
        return matcher.match(input: carNumStr)
    }
    
    /// 密码校验，6-18位数字字母组合
    ///
    /// - Parameter pwd: 密码文本内容
    /// - Returns: true-合法，false-不合法
    static func isStrongPwd(pwd: String) -> Bool {
        if(pwd.isEmpty){
            return false
        }
        let strongPattern = "^(?![a-zA-z]+$)(?!\\d+$)[a-zA-Z\\d]{6,18}$"
        let matcher = MyRegex(strongPattern)
        return matcher.match(input: pwd)
    }
    
}
