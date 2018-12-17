//
//  PageView.swift
//  app
//
//  Created by Apple on 2018/11/25.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit


class PageView: UIView {

    let ContentCellID = "ContentCellID"
    // MARK:- 定义属性
    fileprivate var childVcs : [UIViewController] = []
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    var delegate : PageViewDelegate?
    
    func pageIndexPage(_ index : Int) -> UIViewController {
        return childVcs[index]
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self.bounds.size)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        collectionView.setCollectionViewLayout(layout, animated: false)

    }
    
    

    // MARK:- 自定义构造函数
    public func setData(childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        // 设置UI界面
        self.setupUI()
        collectionView.reloadData()
    }
    

    override func needsUpdateConstraints() -> Bool {
        return true
    }
}
// MARK:- 设置UI界面
extension PageView {
    
    fileprivate func setupUI() {
        // 1.将所有的控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
            childVc.didMove(toParent: parentViewController)
        }
        
       
    }
}


// MARK:- 遵守UICollectionViewDataSource
extension PageView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        // 2.给Cell设置内容
        // 2.1 由于循环利用, 避免循环添加, 先删除所有的子视图
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
// MARK:- 遵守UICollectionViewDelegate
extension PageView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index:Int = Int(scrollView.contentOffset.x/scrollView.frame.width)
        delegate?.pageContentView(self, currentPageIndex: NSNumber.init(value: index))

    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 关闭禁止代理方法
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑动还是右滑动
        let currentOffsetX : CGFloat = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if currentOffsetX > startOffsetX { // 左滑动
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
        } else { // 右滑动
            // 1.计算progres  s
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
            // 4.如果完全划过去
            if startOffsetX - currentOffsetX == scrollViewW {
                progress = 1.0
                sourceIndex = targetIndex
            }
        }
        
        // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageView {
    func setCurrentIndex(_ currentIndex : Int) {
        // 0.记录需要禁止的代理方法
        isForbidScrollDelegate = true
        
        // 1.计算偏移量
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        // 2.设置collectionView的偏移位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
