//
//  ChooseDriverController.swift
//  app
//
//  Created by Apple on 2018/11/23.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class ChooseDriverController: BaseSearchTVController<CardItemVO> {

    var searchText : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lazyTabView.ts_registerCellNib(CardItemCell.self)
        // Do any additional setup after loading the view.
        headRefresh()
        
        keyboardDone = { [weak self]
            text in
            self?.searchText = text
            self?.headRefresh()
        }
    }
    
    //MARK: Public Methods
    override func configNavBar() {
        super.configNavBar()
        addNavDefaultBackButton()
        navTitle = "司机查询"
    }
    
    
    override func getRefreshType() -> TVRefreshEnum {
        return TVRefreshEnum.bothRefresh
    }
    
    override func getNetParameters() -> (netParameter?, method: String, message: String) {
        var np = [String: String]()
        np["searchKey"] = searchText
        return (np,USRACCOUNT_LIST,LOADING)
    }
    
    override func cell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CardItemCell = tableView.ts_dequeueReusableCell(CardItemCell.self)
        return cell
    }
    
    override func itemClick(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, _ item: AnyObject) {
        if(item.isMember(of: CardItemVO.self)){
            let cardItem : CardItemVO = item as! CardItemVO
            
            
        }
    }

}
