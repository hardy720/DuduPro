
//
//  CustomScrollViewTableViewCell.swift
//  MySwiftPro
//
//  Created by 夕阳西下 on 2020/7/27.
//  Copyright © 2020 linglilianchuan. All rights reserved.
//

import UIKit
import PGBannerSwift

class CustomScrollViewTableViewCell: UITableViewCell, PGBannerDelegate {
    func selectAction(didselectAtIndex index: NSInteger, didSelectView view: Any) {
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var items = NSArray(){
        didSet {
            contentView.backgroundColor = .clear
            var arr : [String] = [];
            for picDic in items {
                let pic = picDic as![String:Any]
                let picStr = pic["pictureUrl"]
                let path = "\(BASE_URL)" + "\(picStr ?? "")"
                arr.append(path)
            }
            
            let banner = PGBanner(frame: CGRect.init(x: 15, y: UIDevice.xp_navigationFullHeight(), width: screenWidth - 30, height: 150), imageNameList: arr, placeholderImage: UIImage(named: "photo1"), timeInterval: 3.0)
            banner.layer.cornerRadius = 8
            banner.layer.masksToBounds = true
            banner.delegate = self
            self.addSubview(banner)
        }
    }
    
}
