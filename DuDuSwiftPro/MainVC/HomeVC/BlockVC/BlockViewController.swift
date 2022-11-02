//
//  BlockViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/15/22.
//

import UIKit

class BlockViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let studname = {
            print("Swift 闭包实例。")
        }
        studname()
        
         
//        let add = calc(x: 1, y: 2) { return $0 + $1 }
//        let reduce = calc(x: 4, y: 3) { x, y in return x - y }
//        print(add, reduce)
    }
    
    /**
     闭包作为参数
     */
    func calc(x: Int, y: Int, callback: @escaping (Int, Int) -> Int) -> Int {
        return callback(x, y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nextVC = NextBlockViewController.init()
        /*
         闭包传值
         */
        nextVC.callBackClosure =  {   (str,name) in
            print(str)
            self.showAlert(title: "闭包传值", content: "\(str+name)") { responseCode in
                print(responseCode)
            }
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}


/*
 在OC中习惯用block来传值，而swift中，block被重新定义了一下，叫闭包；
 使用的技巧：谁定义谁传值；
 
 
 */
