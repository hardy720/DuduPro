//
//  MyNavigationController.swift
//  MySwiftPro
//
//  Created by qyt on 2020/7/24.
//  Copyright © 2020 夕阳西下. All rights reserved.
//

/**
 * Rev 0002
 * KMNavigationBarTransition
 */


import UIKit


class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.IOS15NAV()
    }
    
    func IOS15NAV() {
        if #available(iOS 15.0, *) {
            let app = UINavigationBarAppearance()
            app.configureWithOpaqueBackground()
            app.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            app.backgroundColor = .random
            app.shadowColor = .clear
            UINavigationBar.appearance().scrollEdgeAppearance = app
            UINavigationBar.appearance().standardAppearance = app
        }
    }
    
    /**
     * 拦截 push 操作，自定义返回按钮
     * 它会导致导航左侧滑动返回失效  Rev 0001 会解决它。
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let leftBtn = UIButton.init(type: .custom)
            leftBtn.bounds = CGRect.init(x: 0, y: 0, width: 46, height: 46)
            leftBtn.setImage(UIImage.init(named: "whiteBack"), for: .normal)
            leftBtn.addTarget(self, action: #selector(navigationBack), for: .touchUpInside)
            let rightItem = UIBarButtonItem.init(customView: leftBtn)
            viewController.navigationItem.leftBarButtonItem = rightItem
            
            viewController.navigationController?.navigationBar.isHidden = false
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func navigationBack() {
        popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extension MyNavigationController: UIGestureRecognizerDelegate {
//    /// 全局拖拽手势
//    fileprivate func initGlobalPan() {
//        // 创建 pan 手势
//        let target = interactivePopGestureRecognizer?.delegate
//        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
//        globalPan.delegate = self
//        view.addGestureRecognizer(globalPan)
//        // 禁止系统的手势
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//    }
//
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return viewControllers.count != 1
//    }
//}


extension UIColor {
    static var random: UIColor {
        return UIColor(red:   CGFloat.random(in: 0...1),
                       green: CGFloat.random(in: 0...1),
                       blue:  CGFloat.random(in: 0...1),
                       alpha: 1.0)
    }
    
}
