//
//  EmptyView.swift
//  kdlogistics
//
//  Created by Apple on 2017/10/1.
//  Copyright © 2017年 wangwu. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var imageView : UIImageView?
    var message : UILabel?
    override func layoutSubviews() {
        backgroundColor = UIColor.clear
        imageView = UIImageView.init()
            imageView?.contentMode = .center
        imageView?.backgroundColor = UIColor.clear
        imageView?.image = UIImage.init(named: "icon_empty")
        addSubview(imageView!)
        imageView?.snp.makeConstraints({ (make) in
            //make.center.equalTo(superview!)
            make.center.equalTo(superview!)
        })
        if(message == nil){
             message = UILabel()
        }
       
        addSubview(message!)

        message?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(imageView!)
            make.width.equalTo(superview!)
            make.height.equalTo(20)
            make.top.equalTo((imageView?.snp.bottom)!).offset(5)
        })
    
        
        message?.textColor  =  kColor_666666
        message?.numberOfLines = 1
        message?.font = UIFont.appMediumFontOfSize(16)
        message?.textAlignment = .center
        
    }
    
    
    var messageStr : String?{
        didSet{
            if(message == nil){
                message = UILabel()
            }
           message?.text = messageStr
        
        }
        
    }

}
