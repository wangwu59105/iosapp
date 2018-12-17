//
//  SearchView.swift
//  app
//
//  Created by Apple on 2018/11/23.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit

class SearchView: UIView  , UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    
    var keyboardDone : ((_ search : String) -> Void)? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        textField.placeholder = kTextKeyword_Swift
        textField.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textField.background = UIImage.init(named: "searchbox_search_20x28_")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0,left: 9, bottom: 0, right: 9),resizingMode: UIImage.ResizingMode.stretch)
        textField.clearButtonMode = .always  //编辑时不出现，编辑后才出现清除按钮
        textField.font = UIFont.systemFont(ofSize: 14)
        let searchIcon = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        searchIcon.image = UIImage(named: "searchicon_search_20x20_")
        searchIcon.contentMode = .center
        textField.leftView = searchIcon
        textField.leftViewMode = .always
        textField.returnKeyType = UIReturnKeyType.search //表示搜索
        //弹起软键盘
        //searchBar.becomeFirstResponder()
        //隐藏软键盘
        //endEditing(true)
        
        textField.delegate = self
    }
    
    
    override func layoutSubviews() {
        
    }
    
    // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        keyboardDone?(textField.text!)
        return true;
    }
    

    override func needsUpdateConstraints() -> Bool {
        return true
    }
}
