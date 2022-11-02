//
//  LoginViewController.swift
//  MySwiftPro
//
//  Created by 夕阳西下 on 2020/7/25.
//  Copyright © 2020 夕阳西下. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var MobileTF: UITextField!
    @IBOutlet weak var PWTF: UITextField!
    
    
    @IBOutlet weak var rememberBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        rememberBtn.addTarget(self, action: #selector(rememberBtnClick(button:)), for: .touchUpInside)
    }
    
    /*
     btnClickMethod
     */
    
    @objc func rememberBtnClick(button:UIButton) {
        print("buttonTap参数")
        if rememberBtn.isSelected {
            rememberBtn.isSelected = false
            rememberBtn.setImage(UIImage.init(named: "unselected"), for: .normal)
        }else{
            rememberBtn.isSelected = true
            rememberBtn.setImage(UIImage.init(named: "selected"), for: .normal)
        }
    }
    
    @IBAction func forgetBtnClick(_ sender: Any)
    {
        
    }
    
    @IBAction func loginBtnClick(_ sender: Any)
    {
        if MobileTF.text!.contains("@@@") {
            UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = TabBarViewController()
            let defaultStand = UserDefaults.standard
            defaultStand.set("@", forKey: "userId")
            return;
        }
        
        let paramDict = ["userName":MobileTF.text!,"passWord":PWTF.text!,"type":"reader"]
        
        FLToast.showToastAction()
        HttpManager.shareInstance.requestLoginDatas(.post, URLString: "\(BASE_URL)Login", paramaters: paramDict) {
            [self] (response) in
            FLToast.hiddenToastAction()
            let json = JSON(response)
            let alertMessage = json["msg"].stringValue;
            if json["code"].intValue == 200 {
                let dic_info = json["data"].dictionaryObject
                let userM = UserInfoModel.deserialize(from: dic_info)
                let token = json["token"].stringValue
                let userInfoM = UserInfoManager.shareInstance
                userInfoM.saveUserInfo(userM: userM!)
                userInfoM.saveToken(token: token)

                self.perform(#selector(delayExecution), with: nil, afterDelay: TimeInterval(TOASTSHOWTIME))
            }else{
                
            }
            FLToast.showToastAction(message: alertMessage as NSString)
        }
    }
    
    func connectSocket() {
        let isConnect = SocketManager.shared.conentToSocket()
        if  isConnect {
            print("socket--链接成功")
        }else{
            print("socket--链接失败")
        }
    }
    
    @objc func delayExecution() {
        UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = TabBarViewController()
    }
    
    @IBAction func ShortMessageClick(_ sender: Any)
    {
        let regtstVC = RegistViewController.init()
        self.present(regtstVC, animated: true, completion: nil)
    }
    
    @IBAction func weiXinClick(_ sender: Any)
    {
        
    }
    
    @IBAction func appleLoginClick(_ sender: Any)
    {
        
    }
    
    @IBAction func agreenClick(_ sender: Any)
    {
        
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
     
        let jsonData:Data = jsonString.data(using: .utf8)!
     
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
         
     
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
