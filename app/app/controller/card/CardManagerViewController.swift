//
//  CardManagerViewController.swift
//  app
//
//  Created by Apple on 2018/12/14.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class CardManagerViewController: BaseTabController {

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
