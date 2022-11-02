//
//  HttpManager.swift
//  SwiftPro
//
//  Created by 夕阳西下 on 2020/6/19.
//  Copyright © 2020 夕阳西下. All rights SwiftyJSON.swiftreserved.
//


import UIKit
import Alamofire
import SwiftyJSON

private let httpShareInstance = HttpManager()

//数据请求方法
enum MethodType {
    case get
    case post
}

class HttpManager: NSObject {
    //单例
    class var shareInstance: HttpManager {
        return httpShareInstance
    }
}

extension HttpManager
{
    
    /// 网络请求通用版
    /// - Parameters:
    ///   - type: 网络请求方式 get/post
    ///   - URLString: 请求数据路径
    ///   - paramaters: 请求参数
    ///   - finishCallBack: 返回成功以后的值
    /// - Returns:
    func requestLoginDatas(_ type:MethodType, URLString : String, paramaters : [String : Any]?, finishCallBack:@escaping(_ response : Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        AF.request(URLString, method: method , parameters: paramaters).responseJSON { response in
            
            guard response.value != nil else {
                return finishCallBack("")
            }
            
            guard (response.value != nil) else {
                return finishCallBack("")
            }
            
            //成功就把请求的数据回调过去
            if let value = response.value {
                finishCallBack(value)
            }
        }
    }
    

    func requestDatas(_ type:MethodType, URLString : String, paramaters : [String : Any]?, finishCallBack:@escaping(_ response : Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let defaultStand = UserDefaults.standard
        let userId = defaultStand.object(forKey: "userId") ?? ""
        var _parameters = paramaters ?? [:]
        _parameters["userID"] = userId

        let token = defaultStand.string(forKey: "token") ?? ""

        let header: HTTPHeaders = [
            "Accept" :  "application/json",
            "Authorization":token
        ]
        AF.request(URLString, method: method, parameters: _parameters, encoding: URLEncoding.default,headers: header).responseJSON {
            response in
            guard response.value != nil else {
                return finishCallBack("")
            }
            
            guard (response.value != nil) else {
                return finishCallBack("")
            }
            
            //成功就把请求的数据回调过去
            if let value = response.value {
                let json = JSON(value)
                let code = json["code"].intValue;
                if code == 401 {
                    UserInfoManager.shareInstance.removeToken()
                    UserInfoManager.shareInstance.clearUserInfo()
                    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                    window?.rootViewController = LoginViewController()
                }else{
                    finishCallBack(value)
                }
            }
        }
    }
    
    //上传图片请求
    func  uploadPicture(myImg:UIImage,imageKey:String,URlName:String, finishCallBack:@escaping(_ response : Any) -> ()){
        AF.upload(multipartFormData: { (multipartFormData) in
            guard let imgData = myImg.jpegData(compressionQuality: 1) else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmss"
            let dateStr = formatter.string(from: Date())
            let fileName = "\(dateStr).jpg"
            multipartFormData.append(imgData, withName: "file", fileName: fileName, mimeType: "image/jpeg")
        },to: URlName, usingThreshold: UInt64.init(),method: .post).response{ response in
            guard response.value != nil else {
                finishCallBack("")
                return
            }
            guard (response.value != nil) else {
                finishCallBack("")
                return 
            }
            if let value = response.value {
                if let value = response.value {
                    finishCallBack(value)
                }
            }
        }
    }
}
