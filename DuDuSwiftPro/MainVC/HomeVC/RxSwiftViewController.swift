//
//  RxSwiftViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/8/22.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftViewController: BaseViewController {
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    func initUI() {
        /**
         1.按钮事件
         */
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 50, y: kNavigationBarH + 15, width: 80, height: 45)
        btn.setTitle("RX按钮", for: .normal)
        btn.backgroundColor = .green
        self.view.addSubview(btn)
        btn.rx.tap.subscribe { (event : Event<()>) in
            self.showAlert(title: "RXSwift", content: "按钮事件") { code in
                print(code)
            }
        }.disposed(by: bag)

        
        /**
         2.UITextField
         */
        let textfield = UITextField.init(frame: CGRect.init(x: 50, y: kNavigationBarH + 75, width: 100, height: 45))
        textfield.backgroundColor = .orange
        textfield.placeholder = "我是输入框"
        self.view.addSubview(textfield)
        textfield.rx.text.subscribe { (event : Event<String?>) in
            print("0")
            print(event.event);
        }.disposed(by: bag)
                   
        textfield.rx.text.subscribe { (event : Event<String?>) in
            print("1")
            print(event);
        }.disposed(by: bag)
        
        textfield.rx.text.subscribe { (str : String?) in
            print(str!)
        }.disposed(by: bag)
        textfield.rx.text.subscribe { (str : String?) in
            print(str!)
        }.disposed(by: bag)
        
        
        let label1 = UILabel.init(frame: CGRect.init(x: 50, y: kNavigationBarH + 135, width: screenWidth - 100, height: 25))
        label1.backgroundColor = .red
        self.view.addSubview(label1)
        
        textfield.rx.text.bind(to: label1.rx.text).disposed(by: bag)

        /**
         3.label
         */
        label1.rx.observe(String.self, "text").subscribe { (str : String?) in
            print(str!)
        }.disposed(by: bag)
        
        label1.rx.observe(CGRect.self, "frame").subscribe { (frame : CGRect?) in
            print(frame!)
        }.disposed(by: bag)
        
        
        /**
         4.UIScrollview的滚动
         */
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 50, y: kNavigationBarH + 175, width: screenWidth - 100, height: 80))
        scrollView.backgroundColor = .orange
        scrollView.contentSize = CGSize.init(width: screenWidth - 100, height: 160)
        scrollView.rx.contentOffset.subscribe { (p : CGPoint) in
            print(p)
        }.disposed(by: bag)
        self.view.addSubview(scrollView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController (RXSwiftNextViewController.init(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
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

extension RxSwiftViewController {
    
}
