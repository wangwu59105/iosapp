//
//  Data+Extension.swift
//  app
//
//  Created by Apple on 2018/11/21.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import Foundation
import UIKit

extension String {

    func utf8encodedString() ->String {
        var arr = [UInt8]()
        arr += self.utf8
        return String(bytes: arr,encoding: String.Encoding.utf8)!
    }
}



extension UITextView {
    //添加链接文本（链接为空时则表示普通文本）
    func appendLinkString(string:String, withURLString:String = "") {
        //原来的文本内容
        let attrString:NSMutableAttributedString = NSMutableAttributedString()
        attrString.append(self.attributedText)
        
        //新增的文本内容（使用默认设置的字体样式）
        let attrs = [NSAttributedString.Key.font : self.font!]
        let appendString = NSMutableAttributedString(string: string, attributes:attrs)
        //判断是否是链接文字
        if withURLString != "" {
            let range:NSRange = NSMakeRange(0, appendString.length)
            appendString.beginEditing()
            appendString.addAttribute(NSAttributedString.Key.link, value:withURLString, range:range)
            appendString.endEditing()
        }
        //合并新的文本
        attrString.append(appendString)
        
        //设置合并后的文本
        self.attributedText = attrString
    }
}


//MARK: 字体
let appFontLightName   = "PingFangSC-Light"
let appFontRegularName = "PingFangSC-Regular"
let appFontMediumName  = "PingFangSC-Medium"
extension UIFont {
    /**
     更具系统不同返回light字体
     */
    class func appLightFontOfSize(_ fontSize:CGFloat) -> UIFont {
        if #available(iOS 9.0, *)  {
            return UIFont.init(name: appFontLightName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    /**
     更具系统不同返回Regular字体
     */
    class func appRegularFontOfSize(_ fontSize:CGFloat) -> UIFont {
       if #available(iOS 9.0, *)  {
            return UIFont.init(name: appFontRegularName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }else {
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    /**
     更具系统不同返回Medium字体
     */
    class func appMediumFontOfSize(_ fontSize:CGFloat) -> UIFont {
        if #available(iOS 9.0, *)  {
            return UIFont.init(name: appFontMediumName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }else {
            return UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
}

