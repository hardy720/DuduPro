//
//  NextBlockViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/15/22.
//

import UIKit

class NextBlockViewController: BaseViewController {
    typealias SwiftClosure = (String,String) -> Void
    var callBackClosure:SwiftClosure?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
        if callBackClosure != nil{
            callBackClosure!("xiaoming","kuku")
        }
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
