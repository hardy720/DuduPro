//
//  ThirdLibViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 10/27/22.
//

import UIKit

class ThirdLibViewController: BaseViewController ,UITableViewDelegate, UITableViewDataSource {
    
    let itemArr = ["Moya","KMNavigationBarTransition"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        self.title = "第三方库学习"

        //标题设置颜色与字体大小
        view.addSubview(self.tableView)
    }
    
    lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: UIDevice.xp_navigationFullHeight(), width: screenWidth, height: screenHeight - UIDevice.xp_navigationFullHeight()), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
//            tableView.contentInset = UIEdgeInsets.init(top: kIsIphoneX ? -54 : -20, left: 0, bottom: HomeIndicator, right: 0)
        }
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView.init()
        tableView.tableHeaderView = UIView.init()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "thirdItemCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if !(cell != nil) {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = itemArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            navigationController?.pushViewController(MoyaViewController.init(), animated: true)
        }
        if indexPath.row == 1 {
            navigationController?.pushViewController(KMNavigationBarTransitionViewController.init(), animated: true)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
