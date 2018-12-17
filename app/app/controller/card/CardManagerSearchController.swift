//
//  CardManagerSearchController.swift
//  app
//
//  Created by Apple on 2018/12/14.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class CardManagerSearchController: BaseSearchTabController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Public Methods
    override func configNavBar() {
        super.configNavBar()
        addNavDefaultBackButton()
        navTitle = "列表"
    }
    
    
    override func getController() -> ([BaseViewController], [String]) {
        var bvc = [BaseViewController]()
        bvc.append(CardTVController())
        bvc.append(CardTVController())
        bvc.append(CardTVController())
        let titles = ["全部","我的","他人"]
        
        return (bvc,titles)
    }

}
