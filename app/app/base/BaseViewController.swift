//
//  BaseViewController.swift
//  app
//
//  Created by Apple on 2018/11/16.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit
import SnapKit
public class BaseViewController: UIViewController {

    ///普通的tabview
    public lazy var lazyTabView : UITableView = {
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
        //滑动隐藏键盘
        tv.keyboardDismissMode = .onDrag
        //去掉背景色
        tv.backgroundColor = UIColor.clear
        //去掉cell间的白线
        //listView.separatorStyle = .none
        //允许点击
        //listView.allowsSelection = false
        

        return tv
    }()
    
    ///初始化button
    func initButton(_ button : UIButton){
        
    }
    
    //初始化基本按钮
    class func initButton(_ button : UIButton, _ isCancel: Bool)  {
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.contentMode = .center
        button.tintColor = kColor_999999
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.shadowColor = kColor_999999.cgColor
        //设置阴影的偏移量，如果为正数，则代表为往右边偏移
        button.layer.shadowOffset = CGSize.init(width: -5, height: 5)   //阴影的偏移量
        
        button.adjustsImageWhenHighlighted=false //使触摸模式下按钮也不会变暗（半透明）
        button.adjustsImageWhenDisabled=false //使禁用模式下按钮也不会变暗（半透明）
        if(isCancel){
            button.ts_setBackgroundColor(kColor_f5f5f5, forState: .normal)
            button.ts_setBackgroundColor(kColor_f5f5f5, forState: .highlighted)
            button.titleLabel?.textColor = kColor_fda32d
            button.setTitleColor(kColor_fda32d, for: .normal) //普通状态下文字的颜色
            button.layer.borderColor = kColor_fda32d.cgColor
            button.layer.borderWidth = 0.5;
        } else {
            button.titleLabel?.textColor = UIColor.white
            button.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
            button.ts_setBackgroundColor(kColor_fda32d, forState: .normal)
            button.ts_setBackgroundColor(kColor_fda32d, forState: .highlighted)
        }
        
    }
    
    
    var navTitle: String?{
        didSet{
            let titleLabel = UILabel.init(frame: CGRect.zero)
            titleLabel.font = UIFont.appMediumFontOfSize(18)
            titleLabel.textColor = UIColor.white
            titleLabel.text = navTitle
            titleLabel.sizeToFit()
            self.navigationItem.titleView = titleLabel
        }
    }
    
    
    /**
     配置NavBar
     */
    func configNavBar() {
        setNavImage(bgColor: APP_NAV_BG_COLOR, shadowColor: APP_NAV_LINE_COLOR)
    }
    
    
    /**
     设置navBar的颜色
     
     - parameter bgColor:     背景色
     - parameter shadowColor: 阴影色
     
     - returns: self
     */
    func setNavImage(bgColor: UIColor, shadowColor: UIColor) {
        let width = UIScreen.main.bounds.width
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: width, height: 64), false, scale)
        var context = UIGraphicsGetCurrentContext()!
        CGContext.setFillColor(context)(bgColor.cgColor)
        CGContext.addRect(context)(CGRect.init(x: 0, y: 0, width: width, height: 64))
        CGContext.drawPath(context)(using: .fill)
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: width, height: 1), false, scale)
        context = UIGraphicsGetCurrentContext()!
        CGContext.setLineWidth(context)(1)
        CGContext.setStrokeColor(context)(shadowColor.cgColor)
        CGContext.move(context)(to: CGPoint.zero)
        CGContext.addLine(context)(to: CGPoint.init(x: width, y: 0))
        CGContext.drawPath(context)(using: .stroke)
        let shadowImage = UIGraphicsGetImageFromCurrentImageContext()
        
        self.navigationController?.navigationBar.setBackgroundImage(bgImage, for: .default)
        self.navigationController?.navigationBar.shadowImage = shadowImage
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kColor_f3f3f3
        configNavBar()
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavImage(bgColor: APP_NAV_BG_COLOR, shadowColor: APP_NAV_LINE_COLOR)
        navigationController?.navigationBar.isTranslucent = false
    }

    
    //左边nav的点击事件
    @objc func leftButtonAction(_ button: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    /**
     添加默认返回按钮
     */
    @discardableResult
    func addNavDefaultBackButton() -> UIButton {
        let leftBt = UIButton()
        let btImage = UIImage.init(named: "nav_back")
        leftBt.setImage(btImage, for: UIControl.State())
        leftBt.frame.size = (btImage?.size)!
        leftBt.addTarget(self, action: #selector(leftButtonAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBt)
        return leftBt
    }
    
    
    var emptyView : EmptyView?
    func showEmptyView(_ message : String ,_ top : CGFloat? = 0  ){
        if(nil == emptyView){
            emptyView =  EmptyView()
        }else{
             hintEmptyView()
        }
        self.view.addSubview(emptyView!)
        emptyView?.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: top!,left: 0,bottom: top!,right: 0))
        }
        emptyView?.messageStr = message
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEmptyView(_:)))
        emptyView?.isUserInteractionEnabled = true
        emptyView?.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    @objc func tapEmptyView(_ sender: UITapGestureRecognizer) {
        netPageFresh()
    }
    
    //刷新页面，网络空态  无数据空态
    func netPageFresh()  {
        
    }
    
    
    
    func hintEmptyView()  {
        if(emptyView != nil){
            emptyView!.removeFromSuperview()
        }
    }
    
    
    
    //called when users tap out of textfield
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
