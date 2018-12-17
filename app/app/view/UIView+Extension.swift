//
//  UIView+ex.swift
//  app
//  圆角
//  Created by Apple on 2018/11/21.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import Foundation
import UIKit

public extension UIView{
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue > 0 ? newValue : 0 }
        
    }
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
        
    }
}
