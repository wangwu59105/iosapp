//
//  DriverManagerController.swift
//  app
//
//  Created by Apple on 2018/11/23.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class DriverManagerController: BaseSearchViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        keyboardDone = { [weak self]
            text in
            
        }
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
        
        let lineTop = UIView()
        lineTop.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        view.addSubview(lineTop)
        lineTop.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()//.inset(UIEdgeInsets(top: 100,left: 0,bottom:0,right: 0))
        }
        
        
    }
    

  
    //MARK: Public Methods
    override func configNavBar() {
        super.configNavBar()
        addNavDefaultBackButton()
        navTitle = "车辆管理"
    }
    

}
