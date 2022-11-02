//
//  BaseViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 4/25/22.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate/*Rev 0001*/ {
    
    typealias itemClickBlock = (String)->()
    var btnClickblock : itemClickBlock?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
         * Rev 0001
         * 自定义导航返回按钮，会导致左侧滑动返回失效，解决此问题
         */
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.initBaseUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
         * Rev 0001
         * 自定义导航返回按钮，会导致左侧滑动返回失效，解决此问题
         */
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //视图将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置导航栏背景透明
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        if #available(iOS 15.0, *),
//           let appearance = navigationController?.navigationBar.standardAppearance {
//            appearance.backgroundImage = UIImage.creatImageWithColor(color: .random)
//        } else {
//            navigationController?.navigationBar.setBackgroundImage(UIImage.creatImageWithColor(color: .random), for: .default)
//        }
//        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
        
       //视图将要消失
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           //重置导航栏背景
//           self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
           self.navigationController?.navigationBar.shadowImage = nil
        

       }
    
    func showAlert(title: String, content : String,callback:@escaping (Int) -> ()){
        let alert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: "确定", style: .default) { aciton in
            return callback (1)
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel) { cancel in
            return callback (0)
        }
        alert.addAction(action1)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    func showAlertOnlyDefault(title: String, content : String,callback:@escaping (Int) -> ()){
        let alert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: "确定", style: .default) { aciton in
            return callback (1)
        }

        alert.addAction(action1)
        self.present(alert, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BaseViewController {
    func initBaseUI() {
        self.view.backgroundColor = .white
    }
}
