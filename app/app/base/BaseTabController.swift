//
//  BaseTabController.swift
//  app
//
//  Created by Apple on 2018/11/24.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class BaseTabController: BaseViewController {

    
    
    /// tabview 具体顶部的高度  如页面添加了搜索框
    var topHigh : CGFloat = 0
    
    lazy var pageView : PageView = {
        return UIView.ts_viewFromNib(PageView.self)
    }()
    
    var titleView : PageTitleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let bvc_title = getController()
        let titles = bvc_title.1
        let bvcs = bvc_title.0
        
        titleView  = PageTitleView.init(frame: CGRect.init(x: 0, y: topHigh, width: SCREEN_WIDTH, height: 50), titles: titles)
        self.view.addSubview(titleView)
        
        titleView.delegate = self
        // Do any additional setup after loading the view.
        self.view.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            //make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0))
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
                    .inset(UIEdgeInsets(top: 50+topHigh,left: 0,bottom:0,right: 0))
            } else {
                make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 50+topHigh,left: 0,bottom:0,right: 0))
            }
        }
        initTab(bvcs)
    }
    
    
    //MARK: Public Methods
    override func configNavBar() {
        super.configNavBar()
        addNavDefaultBackButton()
    }
    
    
    func initTab(_ bvcs : [BaseViewController]) {
    
        pageView.setData(childVcs: bvcs, parentViewController: self)
        pageView.delegate = self
    }

    //子类集成 重写
    func getController() -> ([BaseViewController] ,[String]){
        let bvc = [BaseViewController]()
        let titles = [String]()
        return (bvc,titles)
    }
    
}
// MARK:- 遵守PageTitleViewDelegate协议
extension BaseTabController : PageTitleViewDelegate {
    func pageTitltView(titleView: PageTitleView, selectedIndex index: Int) {
        pageView.setCurrentIndex(index)
    }

}


// MARK:- 遵守PageContentViewDelegate
extension BaseTabController : PageViewDelegate {
    
    func pageContentView(_ contentView: PageView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        print("\(progress)---\(sourceIndex)-----\(targetIndex)")
    }
    
    func pageContentView(_ contentView: PageView, currentPageIndex: NSNumber) {
        print("\(currentPageIndex)")

    }
   

   
}
