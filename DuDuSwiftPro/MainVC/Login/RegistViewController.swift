//
//  RegistViewController.swift
//  MySwiftPro
//
//  Created by 夕阳西下 on 2021/1/23.
//  Copyright © 2021 夕阳西下. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegistViewController: UIViewController {

    @IBOutlet weak var mobileTF: UITextField!
    
    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var passWordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


    @IBAction func registClick(_ sender: Any) {
        if StringIsEmpty(value: mobileTF.text as AnyObject) || StringIsEmpty(value: passWordTF.text as AnyObject) || StringIsEmpty(value: mobileTF.text as AnyObject){
            FLToast.showToastAction(message: "请检查输入信息")
            return;
        }
        
        let paramDict = ["username":userNameTF.text!,"password":passWordTF.text!,"iphone":mobileTF.text!]

        HttpManager.shareInstance.requestLoginDatas(.post, URLString: "\(BASE_URL)Regist", paramaters: paramDict) { (response) in
            let json = JSON(response)
            let message = json["msg"].stringValue;
            if json["code"].intValue == 200 {
                self.dismiss(animated: true, completion: nil)
            }else{
                
            }
            FLToast.showToastAction(message:message as NSString)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
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
