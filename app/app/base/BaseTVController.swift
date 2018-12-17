//
//  BaseTVController.swift
//  app
//  列表基础类
//  Created by Apple on 2018/11/22.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit
import SnapKit
import CRRefresh

class BaseTVController<Element> : BaseViewController , UITableViewDelegate , UITableViewDataSource,UITVDelegate {
   
   
    ///当前页
    private var mCurrentPage : Int = 1
    ///数据
    var list : [Element] = [Element]()
    /// tabview 具体顶部的高度  如页面添加了搜索框
    var topHigh : CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(lazyTabView)
        //布局
        lazyTabView.snp.makeConstraints { (make)->Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: topHigh,left: 0,bottom: 0,right: 0))
            
        }
        //监听
        lazyTabView.delegate = self
        lazyTabView.dataSource = self
        //默认高度
        lazyTabView.estimatedRowHeight = 40
        lazyTabView.bounces = false
        //注册
        lazyTabView.ts_registerCellNib(BaseTableViewCell.self)
        //添加刷新头尾巴
        initHeadFooter()
    }
    
    ///手动刷新
    func headRefresh() {
        if(getRefreshType() == .headerRefresh || getRefreshType() == .bothRefresh ){
            lazyTabView.cr.beginHeaderRefresh()
        }
    }
    
    ///添加头尾设置
    final func initHeadFooter() {
        let refresh = getRefreshType()
        switch refresh {
        case .noRefresh:
            break
        case .headerRefresh:
            addHeaderRefresh()
            break
        case .footerRefresh:
            addFooterRefresh()
            break
        case .bothRefresh:
            addHeaderRefresh()
            addFooterRefresh()
            break
        }
    }
    ///添加头刷新
    final func addHeaderRefresh(){
        lazyTabView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) {
            [weak self] in
            DispatchQueue.main.ts_safeAsync {
                self?.mCurrentPage = 1
                self?.netPage()
            }
        }
    }
    
    ///添加尾部刷新
    final func addFooterRefresh(){
        lazyTabView.cr.addFootRefresh(animator: NormalFooterAnimator()) {
            [weak self] in
            DispatchQueue.main.ts_safeAsync {
                self?.mCurrentPage  += 1
                self?.netPage()
            }
        }
    }
    
    
    func netPage()  {
    
        hintEmptyView()
        let childTVParam = getNetParameters()
        var parame = childTVParam.0 ??  getParameters()
        parame["pageNum"] = "\(mCurrentPage)"
        parame["pageSize"] = PAGESIZE

        required(p:childTVParam.0, m: childTVParam.method) {[weak self ] response in
            if(self?.mCurrentPage == 1){
                self?.lazyTabView.cr.endHeaderRefresh()
            }else{
                self?.lazyTabView.cr.endLoadingMore()
            }
            switch response.result {
            case .success:
                if let base = BaseVO<ListPageVO<Element>>.deserialize(from: response.result.value ?? ""){
                    if(self?.mCurrentPage == 1){
                        self?.list.removeAll()
                    }
                    if let listpage = base.data{
                        if(nil != listpage.rows){
                            self?.list += listpage.rows!
                            self?.lazyTabView.reloadData()
                        }
                        if(listpage.hasNextPage ?? false){
                            self?.lazyTabView.cr.resetNoMore()
                        }else{
                            self?.lazyTabView.cr.noticeNoMoreData()
                        }
                    }
                }
                break
            case .failure(let error):
                ToastView.showMessage(error.localizedDescription)
                break
            }
            
            if(self?.list.count == 0){
                self?.showEmptyView(kTextNoData_Swift,CGFloat( SEARCH_HIGH))
            }
        }
    }
    
    ///点击空开
    override func netPageFresh() {
        headRefresh() 
    }
    
    
    ///继承类需要返回
    func getNetParameters() -> (netParameter?, method: String, message: String) {
       
        let np = [String: String]()
        return (np,"",LOADING)
      }
    
   
    
    ///继承类根据需求重写
    func getRefreshType() -> TVRefreshEnum {
        return TVRefreshEnum.noRefresh
    }
    
    ///tabview的基础设置
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item: Element = self.list[(indexPath as NSIndexPath).row]
        itemClick(tableView, didSelectRowAt: indexPath, item as AnyObject)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(tableView , cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    //用户设置
    func cell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BaseTableViewCell = tableView.ts_dequeueReusableCell(BaseTableViewCell.self)
        return cell
        
    }
    //用户设置
    func itemClick(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, _ item: AnyObject) {
        
    }
    

}
