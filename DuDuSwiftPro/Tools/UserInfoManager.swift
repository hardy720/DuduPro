//
//  UserInfoManager.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 4/23/22.
//

import UIKit

private let userInfoShareInstance = UserInfoManager()


class UserInfoManager: NSObject {
    //单例
    class var shareInstance: UserInfoManager {
        return userInfoShareInstance
    }
}

extension UserInfoManager{
    
    func isLogin() -> Bool {
        let defaultStand = UserDefaults.standard
        let token = defaultStand.object(forKey: "token")
        if StringIsEmpty(value: token as AnyObject) {
            return false
        }
        return true
    }
    
    func logOut() {
        self.removeToken()
        self.clearUserInfo()
    }
    
    func saveUserInfo(userM : UserInfoModel) {
        let defaultStand = UserDefaults.standard
        defaultStand.setValue(userM.iphone, forKey: "iphone")
        defaultStand.setValue(userM.id, forKey: "userId")
        defaultStand.setValue(userM.createtime, forKey: "createtime")
        defaultStand.setValue(userM.passWord, forKey: "passWord")
        defaultStand.setValue(userM.userName, forKey: "userName")
        defaultStand.setValue(userM.profilephoto, forKey: "profilephoto")
        defaultStand.synchronize()
    }
    
    func saveToken(token : String){
        let defaultStand = UserDefaults.standard
        defaultStand.setValue(token, forKey: "token")
        defaultStand.synchronize()
    }
    
    func removeToken(){
        let defaultStand = UserDefaults.standard
        defaultStand.removeObject(forKey: "token")
        defaultStand.synchronize()
    }
    
    func clearUserInfo() {
        let defaultStand = UserDefaults.standard
        defaultStand.removeObject(forKey: "iphone")
        defaultStand.removeObject(forKey: "userId")
        defaultStand.removeObject(forKey: "createtime")
        defaultStand.removeObject(forKey: "passWord")
        defaultStand.removeObject(forKey: "userName")
        defaultStand.removeObject(forKey: "profilephoto")
        defaultStand.synchronize()
    }
}
