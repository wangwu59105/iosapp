//
//  ViewController.swift
//  app
//
//  Created by Apple on 2018/11/15.
//  Copyright © 2018年 wangwu. All rights reserved.
//

import UIKit
import Alamofire
import Cache
class ViewController: BaseViewController {
    
    @IBOutlet weak var textFieldHigh: NSLayoutConstraint!
    @IBOutlet weak var paddingLabel: UILabelPadding!
    @IBOutlet weak var textField: TextFieldCounter!
    @IBOutlet weak var tips: UILabel!
    @IBAction func net(_ sender: UIButton) {
          netLoad()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initStorage()
        textField.isHidden = true
        textFieldHigh.constant = 0

    }

    func initStorage() {
        

    }
    
    override func configNavBar() {
        super.configNavBar()
        navTitle = "登录"
    }
    
    @IBAction func textField(_ sender: Any) {
        
        textField.isHidden = !textField.isHidden

        if(textField.isHidden){
            textFieldHigh.constant = 0
        }else{
             textFieldHigh.constant = 30
        }
    }
    
    func netLoad()  {
    
        HttpTools.login("13477037506", "wangwu852369", completionHandler: { [weak self](base) in
            ToastView.showMessage(base.data?.firstName ?? "")
            self?.navigationController?.pushViewController(CardTVController(), animated: true)
        }, errorHandler: { (error) in
            ToastView.showMessage(error)
        })
    }

    @IBAction func searchController(_ sender: Any) {
        navigationController?.pushViewController(DriverManagerController(), animated: true)
    }
    
    
    
    @IBAction func searhTVController(_ sender: Any) {
       navigationController?.pushViewController(ChooseDriverController(), animated: true)
    }
    @IBAction func tabController(_ sender: Any) {
        navigationController?.pushViewController(CardManagerViewController(), animated: true)
        //present(BaseTabController(), animated: true, completion: nil)
        
    }
    
    @IBAction func tabSearchController(_ sender: Any) {
        
         navigationController?.pushViewController(CardManagerSearchController(), animated: true)
        
    }
    @IBAction func padding(_ sender: Any) {
        paddingLabel.isHidden  = !paddingLabel.isHidden
    }
}

