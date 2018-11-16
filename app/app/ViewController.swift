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
class ViewController: UIViewController {
    
    @IBAction func net(_ sender: UIButton) {
          netLoad()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initStorage()
    }

    func initStorage() {
        

    }
    
    func netLoad()  {
        Alamofire.request("https://httpbin.org/get").responseString { response in
            switch response.result {
            case .success:
                if let user = User.deserialize(from: response.result.value ?? ""){
                    ToastView.showMessage(user.url ?? "")
                    
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
    }

}

