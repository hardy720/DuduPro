//
//  MineViewController.swift
//  MySwiftPro
//
//  Created by qyt on 2020/7/24.
//  Copyright © 2020 夕阳西下. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class MineViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    let titleArr = ["知识点总结","修改密码","手机号","生日","我的喜好","退出登录"]
    var p_headImg : UIImageView?
    var p_userNameLabel : UILabel?

    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.initUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        self.tabBarController!.tabBar.isHidden = false
        self.getData()
    }
    
    func getData()  {
        HttpManager.shareInstance.requestDatas(.post, URLString: "\(BASE_URL)/mySerlet/userinfo", paramaters: nil) { response in
            let json = JSON(response)
            let message = json["msg"].stringValue;
            if json["code"].intValue == 200 {
                let dic_info = json["data"].dictionaryObject
                
                let userM = UserInfoModel.deserialize(from: dic_info)
                let userInfoM = UserInfoManager.shareInstance
                userInfoM.saveUserInfo(userM: userM!)
                

                
                self.tableView.reloadData()
                
                self.p_userNameLabel?.text = userM?.userName
                let ss = "\(BASE_URL)\(userM?.profilephoto ?? "")"
                self.p_headImg!.kf.setImage(with: URL(string: ss),placeholder: UIImage.init(named: "person_head"))
            }else{
                FLToast.showToastAction(message:message as NSString)
            }
        }
    }
    
    func initUI() {
        view.addSubview(self.tableView)
    }
    
    lazy var headView : UIImageView = {
        var headView : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 260))
        headView.backgroundColor = .white
        headView.image = UIImage.init(named: "peoson_1")
        
        let headV = UIImageView.init(frame: CGRect.init(x: screenWidth/2 - 50, y: UIDevice.xp_navigationFullHeight() + 10, width: 100, height: 100))
        headV.layer.cornerRadius = 50
        headV.layer.masksToBounds = true
        headV.image = UIImage.init(named: "person_head")
        self.p_headImg = headV
        headView.addSubview(headV)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(singleTap))
        headView.addGestureRecognizer(tap)
        headView.isUserInteractionEnabled = true

        let userNameLabel = UILabel.init(frame: CGRect.init(x: 15, y: 120 + UIDevice.xp_navigationFullHeight(), width: screenWidth - 30, height: 32))
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.init(name: "Helvetica-Bold", size: 25)
        userNameLabel.textAlignment = .center
        p_userNameLabel = userNameLabel;
        headView.addSubview(userNameLabel)
        
        return headView
    }()
    
    @objc func singleTap()  {
        let alertVC = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        weak var weakSelf = self

        let takePhone = UIAlertAction.init(title: "相机", style: .default) { action in
            weakSelf?.initCameraPicker()

        }
        let cameraAction = UIAlertAction.init(title: "相册", style: .default) { action in
            weakSelf?.initPhotoPicker()
        }
        let quxiao = UIAlertAction.init(title: "取消", style: .cancel)

        alertVC.addAction(takePhone)
        alertVC.addAction(cameraAction)
        alertVC.addAction(quxiao)

        self.present(alertVC, animated: true)
    }
    
    //从相册中选择
    func initPhotoPicker(){
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        self.present(photoPicker, animated: true, completion: nil)
    }
    //拍照
    func initCameraPicker(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        picker.dismiss(animated: true) { [weak self] in
        }
        
        HttpManager.shareInstance.uploadPicture(myImg: image, imageKey: "file", URlName: "\(BASE_URL)/uploadImg") { response in
            let json = JSON(response)
            let message = json["msg"].stringValue;
            if json["code"].intValue == 200 {
                self.updateUserInfo(headUrl: json["data"].stringValue)
            }else{
                FLToast.showToastAction(message:message as NSString)
            }
        }
    }
    
    func updateUserInfo(headUrl: String) {
        let param = ["profilephoto":headUrl]
        HttpManager.shareInstance.requestDatas(.post, URLString: "\(BASE_URL)/mySerlet/updateprofilephoto", paramaters: param) { response in
            let json = JSON(response)
            let message = json["msg"].stringValue;
            if json["code"].intValue == 200 {
                let ss = "\(BASE_URL)\(headUrl)"
                self.p_headImg!.kf.setImage(with: URL(string: ss),placeholder: UIImage.init(named: "person_head"))
            }
            FLToast.showToastAction(message: message as NSString)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            [weak self] in
        }
    }
    
    lazy var tableView:UITableView = {
        var tableview : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: -UIDevice.xp_navigationFullHeight(), width: screenWidth, height: screenHeight), style: .plain)
        tableview.delegate = self
        tableview.dataSource = self;
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.tableFooterView = UIView()
        tableview.tableHeaderView = self.headView
        let backImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight))
        backImg.image = UIImage.init(named: "person_2")
        tableview.backgroundView = backImg
        return tableview
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "personCell");
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "personCell")
            cell?.accessoryType = .disclosureIndicator
        }
        cell?.contentView.backgroundColor = .clear
        cell?.backgroundColor = .clear
        cell?.textLabel?.text = self.titleArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            navigationController?.pushViewController(KnowledgeViewController.init(), animated: true)
        }
        
        
        if indexPath.row == 5 {
            let alert = UIAlertController.init(title: "温馨提示", message: "确定退出登录", preferredStyle: .alert)
            let que = UIAlertAction.init(title: "确定", style: .default) { (queding) in
                UserInfoManager.shareInstance.logOut()
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                window?.rootViewController = LoginViewController()
            };
            let cancel = UIAlertAction.init(title: "取消", style: .cancel) { (cancel) in
                
            }
            alert.addAction(que)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
}


