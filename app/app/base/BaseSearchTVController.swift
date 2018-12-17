//
//  BaseSearchTVController.swift
//  app
//
//  Created by Apple on 2018/11/23.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class BaseSearchTVController<Element>: BaseTVController<Element> {

    ///搜索的高度
    let search_high  =  SEARCH_HIGH
    var keyboardDone : ((_ search : String) -> Void)? = nil
    override func viewDidLoad() {
        //父类初始化之前加入高度
        topHigh = CGFloat(search_high)
        super.viewDidLoad()
        let searchView = UIView.ts_viewFromNib(SearchView.self)
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(search_high)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        // Do any additional setup after loading the view.
        searchView.keyboardDone = { [weak self]
            text in
            if(nil != self?.keyboardDone){
                self?.keyboardDone!(text)
            }
        }
    }
    

}
