//
//  SwiftUIViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/17/22.
//

import UIKit

class SwiftUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}
