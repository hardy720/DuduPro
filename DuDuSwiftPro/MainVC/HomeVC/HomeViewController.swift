//
//  HomeViewController.swift
//  MySwiftPro
//
//  Created by qyt on 2020/7/24.
//  Copyright © 2020 linglilianchuan. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class HomeViewController: BaseViewController ,UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,ItemTableViewCellDelegate{

    var myDataListArr = Array <Any>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.isHidden = true

        self.view.addSubview(self.tableView)
        self.getData()
        
        let str = "1725486717@qq.com"
        if str.isValidEmailStricterFilter() {
            print("是邮箱")
        }else{
            print("不是邮箱")
        }
    }
    
    
    
    func getData() {
        HttpManager.shareInstance.requestDatas(.post, URLString: "\(BASE_URL)/mySerlet/getHomeList", paramaters: nil) { (response) in
            self.tableView.mj_header?.endRefreshing()
            let json = JSON(response)
            var message = json["msg"].stringValue;
            if json["code"].intValue == 200 {
                self.myDataListArr = json["data"].arrayObject!
                self.tableView.reloadData()
            }else{
                if message.isEmpty {
                    message = "网络故障"
                }
            }
        }
    }
    
    lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: -UIDevice.xp_navigationFullHeight(), width: screenWidth, height: screenHeight), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self;
        if #available(iOS 11.0, *) {
//            tableView.contentInset = UIEdgeInsets.init(top: kIsIphoneX ? -54 : -20, left: 0, bottom: HomeIndicator, right: 0)
        }
        tableView.register(CustomScrollViewTableViewCell.self, forCellReuseIdentifier:"P001ID")
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier:"P002ID")
        tableView.register(HomeListTableViewCell.self, forCellReuseIdentifier:"P003ID")


        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView.init()
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headRefresh))
        tableView.mj_header = header
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let infoDict = self.myDataListArr[section] as! NSDictionary
        let modules = infoDict["modules_num"] as! String
        if (modules == "P003") {
            let itemArr = infoDict["P003"] as! NSArray
            return itemArr.count;
        }
        return 1;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.myDataListArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let infoDict = self.myDataListArr[indexPath.section] as! NSDictionary
        let modules = infoDict["modules_num"] as! String
        if modules ==  "P001"{
            return 200 + UIDevice.xp_navigationFullHeight();
        }
        if modules == "P002" {
            return 180
        }
        if modules == "P003" {
            return 180
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let infoDict = self.myDataListArr[indexPath.section] as! NSDictionary
        let modules = infoDict["modules_num"] as! String
        if modules ==  "P001" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "P001ID", for: indexPath) as! CustomScrollViewTableViewCell
            cell.items = infoDict["P001"] as! NSArray
            return cell
        }else if (modules ==  "P002") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "P002ID", for: indexPath) as! ItemTableViewCell
            cell.delegate = self
            return cell
        }else if (modules ==  "P003") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "P003ID", for: indexPath) as! HomeListTableViewCell
            let items = infoDict["P003"] as! NSArray
            cell.items = items[indexPath.row] as! NSDictionary
            return cell
        }else{
            let cellID = "publicCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            if !(cell != nil) {
                cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellID)
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    @objc func headRefresh() {
        self.myDataListArr.removeAll()
        self.getData()
    }
    
    func itemBtnClick(_ indexItem: Int) {
        print("\(indexItem)"+"1111111")
        if indexItem == 100 {
            FLToast.showToastAction(message: "Swift Delegate的使用")

            let RXSwiftVC = RxSwiftViewController.init()
            navigationController?.pushViewController(RXSwiftVC, animated: true)
        }
        
        if indexItem == 101 {
            FLToast.showToastAction(message: "Swift Block的使用")

            let blockVC = BlockViewController.init()
            navigationController?.pushViewController(blockVC, animated: true)
        }
        
        if indexItem == 102 {
            self.showAlertOnlyDefault(title: "提示", content: "Swift UI最低支持的版本是iOS13，暂时不做详细学习。等更新一段时间吧") { code in
                print(code)
            }
        }
        
        
        if indexItem == 103 {
            self.showAlertOnlyDefault(title: "UDID", content: getIdentifierNumber()) { code in
                print(code)
            }
        }
        
        if indexItem == 104 {
            let thirdLibVC = ThirdLibViewController.init()
            navigationController?.pushViewController(thirdLibVC, animated: true)
        }
        
        if indexItem == 105 {
            let interviewVC = InterviewViewController.init()
            navigationController?.pushViewController(interviewVC, animated: true)
        }
        
        if indexItem == 106 {
            let giftVC = ShowGiftViewController.init()
            navigationController?.pushViewController(giftVC, animated: true)
        }
        if indexItem == 107 {
            navigationController?.pushViewController(EnglishViewController.init(), animated: true)
        }
    }
    
    //param customDelegate
    func clickItem(index: Int) {
        if index == 0 {
        }
        if index == 1 {
        }
        if index == 2 {
        }
        if index == 3 {
        }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        self.getData()
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let showStr = "无数据,请重新加载"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: showStr, attributes: [NSAttributedString.Key.font:UIFont(name:"Georgia", size:14.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.green, range:NSRange(location:5,length:4))
        //添加不同字体大小
        myMutableString.addAttribute(NSAttributedString.Key.font, value:UIFont.systemFont(ofSize: 18.0), range:NSRange(location:5,length:4))
        return myMutableString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let enmptyImg = UIImage.init(named: "NODATA")
        return enmptyImg
    }
}
