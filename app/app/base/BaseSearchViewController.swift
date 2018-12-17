//
//  BaseSearchViewController.swift
//  app
//
//  Created by Apple on 2018/11/23.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class BaseSearchViewController: BaseViewController {

    ///搜索的高度
    let search_high  =  SEARCH_HIGH
    var keyboardDone : ((_ search : String) -> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
