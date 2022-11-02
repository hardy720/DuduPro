//
//  API.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 3/30/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//https://github.com/Moya/Moya/blob/master/docs_CN/Examples/Basic.md

import Foundation
import Moya

enum API{
    case updateAPi(parameters:[String:Any])
    case register(email:String,password:String)
    //上传用户头像
    case uploadHeadImage(parameters: [String:Any],imageDate:Data)
    case easyRequset
    case moyaRequest1(parameters:[String:Any])
    case moyaRequest2(parameters:[String:Any])
}

extension API:TargetType {
    
    var baseURL: URL {
        switch self {
        case .easyRequset:
            return URL.init(string:"http://news-at.zhihu.com/api/")!
        case .moyaRequest1:
            return URL.init(string: BASE_URL)!
        case .moyaRequest2:
            return URL.init(string: BASE_URL)!
        default:
            return URL.init(string:(Moya_baseURL))!
        }
    }
    
    var path: String {
        switch self {
        case .moyaRequest1:
            return "/mySerlet/moyatest"
        case .moyaRequest2:
            return "moyatesttwo"
        case .register:
            return "register"
        case .easyRequset:
            return "4/news/latest"
        case .updateAPi:
            return "versionService.getAppUpdateApi"
        case .uploadHeadImage( _):
            return "/file/user/upload.jhtml"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .easyRequset:
            return .get
        case .moyaRequest2:
            return .get
        default:
            return .post
        }
    }
    

    //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    //    该条请API求的方式,把参数之类的传进来
    var task: Task {
        switch self {
        case let .moyaRequest2(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .moyaRequest1(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .register(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .easyRequset:
            return .requestPlain
        case let .updateAPi(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        //图片上传
        case .uploadHeadImage(let parameters, let imageDate):
            ///name 和fileName 看后台怎么说，   mineType根据文件类型上百度查对应的mineType
            let formData = MultipartFormData(provider: .data(imageDate), name: "file",
                                              fileName: "hangge.png", mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
       
        //可选参数https://github.com/Moya/Moya/blob/master/docs_CN/Examples/OptionalParameters.md
//        case .users(let limit):
//        var params: [String: Any] = [:]
//        params["limit"] = limit
//        return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
 
    
    
    var headers: [String : String]? {
        let defaultStand = UserDefaults.standard
        let token = defaultStand.string(forKey: "token") ?? ""
        let additionalParameters = ["Authorization":token,"Accept" :  "application/json",]
        return additionalParameters
    }
 
}
