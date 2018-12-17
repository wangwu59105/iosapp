//
//  PageViewDelegate.swift
//  app
//
//  Created by Apple on 2018/11/25.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import Foundation
import UIKit

protocol PageViewDelegate  {
    func pageContentView(_ contentView: PageView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
    func pageContentView(_ contentView: PageView, currentPageIndex: NSNumber)
}
