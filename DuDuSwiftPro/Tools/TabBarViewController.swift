//
//  TabBarViewController.swift
//  SwiftPro
//
//  Created by 夕阳西下 on 2020/6/20.
//  Copyright © 2020 夕阳西下. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var indexFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addChildControllers()
    }
    
    private func addChildControllers() {
        addChildControllers(HomeViewController(), title: "首页", image: "home_tabbar_night_32x32_", selectImg: "home_tabbar_press_32x32_")
        addChildControllers(ClassViewController(), title: "第二", image: "huoshan_tabbar_night_32x32_", selectImg: "huoshan_tabbar_press_32x32_")
        addChildControllers(CarViewController(), title: "第三", image: "video_tabbar_night_32x32_", selectImg: "video_tabbar_press_32x32_")
        addChildControllers(MineViewController(), title: "第四", image: "mine_tabbar_night_32x32_", selectImg: "mine_tabbar_press_32x32_")
    }
    
    private func addChildControllers(_ childVC: UIViewController,title: String,image:String, selectImg: String){
        //item文字
        childVC.tabBarItem.title = title
        //未选中图片
        childVC.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        //选中图片
        childVC.tabBarItem.selectedImage = UIImage(named: selectImg)?.withRenderingMode(.alwaysOriginal)
        //选中文字颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], for: .selected)
        //头部导航
        let nav = MyNavigationController(rootViewController: childVC)
//        nav.addChild(childVC)
        addChild(nav)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            if indexFlag != index {
                animationWithIndex(index: index)
            }
        }
    }
    
    private func animationWithIndex(index: Int){
        var arrViews = [UIView]()
        //遍历tabbar子视图拿到可点击的item加入到数组
        for tabbarButton in tabBar.subviews {
            if tabbarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                arrViews.append(tabbarButton)
            }
        }
        
        //缩放动画
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        //动画函数
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulse.duration = 0.1
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = NSNumber(value: 0.7)
        pulse.toValue = NSNumber(value: 1.1)
        
        //添加动画到item
        arrViews[index].layer.add(pulse, forKey: nil)
        indexFlag = index
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], for: .selected)

    }
}
