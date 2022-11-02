//
//  RXSwiftNextViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/16/22.
//

import UIKit
import RxSwift
import RxCocoa

class RXSwiftNextViewController: UIViewController {
    let peopleList = PeopleListModel()
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        peopleList.data.bind(to: tableView.rx.items(cellIdentifier: "myCell")){ _, model,cell in
            cell.textLabel?.text = String(model.name)
            cell.detailTextLabel?.text = String(model.age)
        }.disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(People.self).subscribe { (people) in
            print("选择了\(people)")
            let documentVC = RXDocumentViewController.init()
            self.navigationController?.pushViewController(documentVC, animated: true)
        }.disposed(by: disposeBag)

    }
}
