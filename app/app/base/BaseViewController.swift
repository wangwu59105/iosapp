//
//  BaseViewController.swift
//  app
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    ///普通的tabview
    lazy var tabView : UITableView = {
        let tv = UITableView()
        //去底部多余
        tv.tableFooterView = UIView()
        //设置分割线样式
        tv.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        //设置分割线颜色
        tv.separatorColor = UIColor.lightGray
        //设置分割线内边距
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //非整屏滑动
        tv.isPagingEnabled = false
        //去掉cell间的白线
        //listView.separatorStyle = .none
        //允许点击
        //listView.allowsSelection = false
        return tv
    }()
    
    ///初始化button
    func initButton(_ button : UIButton){
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
