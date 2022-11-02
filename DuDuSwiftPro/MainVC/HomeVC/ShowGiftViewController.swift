//
//  ShowGiftViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 6/7/22.
//

import UIKit
import PGBannerSwift


class ShowGiftViewController: UIViewController, PGBannerDelegate {
    
    var gitImg : UIImageView?
    var randomCount : String?
    
    func selectAction(didselectAtIndex index: NSInteger, didSelectView view: Any) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        let arr = ["test1.gif","test2.gif","test3.gif"];
        
        let img = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight))
        img.backgroundColor = .black
        img.isUserInteractionEnabled = true
        img.image = UIImage.gif(name: "test4")
        img.contentMode = .center
        self.view.addSubview(img)
        self.gitImg = img
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imgClick))
        img.addGestureRecognizer(tap)
    }
    
    @objc func imgClick() {
        var numberThree : Int = Int(arc4random_uniform(4))
        randomCount = String(numberThree)
        let ss = "test\(randomCount ?? "")"
        print(ss)
        self.gitImg?.image = UIImage.gif(name: ss)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = false
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
