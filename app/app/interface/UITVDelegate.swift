//
//  UITVDelegate.swift
//  app
//
//  Created by Apple on 2018/11/22.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

protocol UITVDelegate{
    ///添加Cell 如果是多样化的  用户自己重写基础属性
    func cell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    ///列表点击 
    func itemClick(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath,_ item : AnyObject)
    ///上拉下拉
    func getRefreshType() -> TVRefreshEnum
    /// 分别是请求的入参  方法名字  加载的显示文字
    func getNetParameters() ->(netParameter? ,method : String , message: String)
    
}

