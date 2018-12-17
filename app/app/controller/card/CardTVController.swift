//
//  CardTVController.swift
//  app
//
//  Created by Apple on 2018/11/22.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class CardTVController: BaseTVController<CardItemVO>  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lazyTabView.ts_registerCellNib(CardItemCell.self)
        // Do any additional setup after loading the view.
        headRefresh()
    }
    
    //MARK: Public Methods
    override func configNavBar() {
        super.configNavBar()
        addNavDefaultBackButton()
        navTitle = "账户列表"
    }
    
    
    override func getRefreshType() -> TVRefreshEnum {
        return TVRefreshEnum.headerRefresh
    }
    
    override func getNetParameters() -> (netParameter?, method: String, message: String) {
        let np = [String: String]()
        return (np,USRACCOUNT_LIST,LOADING)
    }
    
    override func cell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CardItemCell = tableView.ts_dequeueReusableCell(CardItemCell.self)
        return cell
    }
    
    override func itemClick(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, _ item: AnyObject) {
        if(item.isMember(of: CardItemVO.self)){
            let cardItem : CardItemVO = item as! CardItemVO
            navigationController?.pushViewController(DriverManagerController(), animated: true)
        }
    }

}
