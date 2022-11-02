//
//  MoyaViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/19/22.
//

import UIKit
import Moya

class MoyaViewController: BaseViewController {
    var cancelableRequest: Cancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Moya"
        
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 有些时候的需求是页面退出是取消网络请求。
        cancelableRequest?.cancel()
    }

    @IBAction func moya1(_ sender: Any) {
        cancelableRequest = NetWorkRequest(API.easyRequset, modelType: [ZhihuItemModel].self, successCallback: {(zhihuModels, responseModel) in zhihuModels.forEach({ (item) in
//                print("模型属性--\(item.title ?? "模型无title")" )
                self.showAlertOnlyDefault(title: "返回数据", content: item.title ?? "模型无title") { code in
                    
                }
        })
        }, failureCallback: { (responseModel) in
            print("网络请求失败 包括服务器错误和网络异常\(responseModel.code)__\(responseModel.message)")
        })
    }
    
    
    @IBAction func Moya2(_ sender: Any)
    {
        cancelableRequest = NetWorkRequest(API.moyaRequest1(parameters: ["username":"1111"]), needShowFailAlert: true, modelType: [moyaTest1].self, successCallback: {moyatestM ,responseModel in moyatestM.forEach({ (item) in
            print(item.title ?? "");
            print(item.create_time ?? "");
        })
        }, failureCallback: { (responseModel) in
            print("网络请求失败 包括服务器错误和网络异常\(responseModel.code)__\(responseModel.message)")
        })
    }
    
    @IBAction func Moya3(_ sender: Any)
    {
        cancelableRequest = NetWorkRequest(API.moyaRequest2(parameters: ["username":"1111"]), needShowFailAlert: true, modelType: [Moyatest2].self, successCallback: {moyatestM ,responseModel in
            print(moyatestM)
            let item = moyatestM[0]
            print(item.title ?? "");
            print(item.create_time ?? "");
        }, failureCallback: {_ in
            
        })
    }
    
    @IBAction func Moya4(_ sender: Any) {
    }
    
    
    @IBAction func Moya5(_ sender: Any) {
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
