//
//  VideoItemCollectionViewCell.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 6/9/22.
//

import UIKit

class VideoItemCollectionViewCell: UICollectionViewCell {

    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    var titleLabel : UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .gray
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.text = "理发师付律师费独守空房绿色防控就"
        return titleLabel
    }()
    
    var backImg: UIImageView = {
        let image = UIImage(named: "xxxsoer")
        let imageView  = UIImageView();
            imageView.image = image
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.backImg.layer.cornerRadius = 8
        self.backImg.layer.masksToBounds = true
        
        self.addSubview(self.backImg)
        self.backImg.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-35)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.backImg.snp.bottom).offset(5)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(30)
        }
        
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
