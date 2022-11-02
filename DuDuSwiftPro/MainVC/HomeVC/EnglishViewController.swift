//
//  EnglishViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 6/9/22.
//

import UIKit

class EnglishViewController: BaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initUI()
    }
    
    func initUI() {
        self.view.addSubview(self.collectView)
    }
    
    lazy var collectView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: screenWidth / 2 - 25 , height: 200)
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 20
        let collectView = UICollectionView.init(frame: CGRect.init(x: 15, y: 15, width: screenWidth - 30, height: screenHeight), collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.showsVerticalScrollIndicator = true
        collectView.register(VideoItemCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SwiftCollectionViewCell")
        return collectView
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellString = "SwiftCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellString, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let videoVC = PlayVideoViewController.init()
        let videoVC = CusPlayVideoViewController.init()

        navigationController?.pushViewController(videoVC, animated: true)
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
