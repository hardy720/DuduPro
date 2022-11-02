//
//  CustomAlertView.swift
//  FeedsPro
//
//  Created by LiquidUIMac on 12/20/21.
//

import UIKit

class CustomAlertView: UIView {
    
    typealias RightBtnClickBlock = ()->Void;
    var leftblock : LeftBtnClickBlock?;
    typealias LeftBtnClickBlock = ()->Void;
    var rightblock : RightBtnClickBlock?;

    init(frame: CGRect, content: String , title: String ,leftBtnTitle: String,rightBtnTitle: String) {
        super.init(frame: frame)
        self.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)

        keyWindow.addSubview(self)
        
        let strH = content.getTextHeigh(font: .systemFont(ofSize: 15), width: screenWidth - 100) + 10
        
        var top_Y = 16
        var contentV_h = 0
        if title.StrIsBlank != true {
            top_Y = 45
            contentV_h = Int(strH + 110)
        }else{
            contentV_h = Int(strH + 70)
        }
        
        let contentV = UIView.init(frame: CGRect.init(x: 35, y: (Int(screenHeight) - contentV_h)/2, width: Int(screenWidth) - 70, height: contentV_h))
        contentV.backgroundColor = .black
        contentV.layer.cornerRadius = 8
        contentV.layer.masksToBounds = true
        self.addSubview(contentV)
                
        
        let titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = .font(size: 16, weight: .thin)
        titleLabel.textColor = .black
        contentV.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentV).offset(16)
            make.left.right.equalTo(contentV)
            make.height.equalTo(25)
        }
        
        
        let contentLabel = UILabel.init()
        contentLabel.text = content
        contentLabel.textAlignment = .center
        contentLabel.font = .font(size: 16, weight: .thin)
        contentLabel.textColor = .white
        contentLabel.numberOfLines = 0
        contentV.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(top_Y)
            make.left.equalTo(contentV).offset(15)
            make.right.equalTo(contentV).offset(-15)
            make.height.equalTo(strH)
        }
        
        
        let lineLabel = UILabel.init()
        lineLabel.backgroundColor = .black
        contentV.addSubview(lineLabel)
        lineLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentV.snp.bottom).offset(-15)
            make.height.equalTo(25)
            make.width.equalTo(1.5)
            make.centerX.equalTo(contentV)
        }
        
        let item_x = ((screenWidth - 60)/2 - 80)/2
        
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.setTitleColor(.white, for: .normal)
        leftBtn.titleLabel?.font = .font(size: 16, weight: .thin)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        leftBtn.setTitle(leftBtnTitle, for: .normal)
        contentV.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.left.equalTo(item_x)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerY.equalTo(lineLabel)
        }
        
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.setTitleColor(.white, for: .normal)
        rightBtn.setTitle(rightBtnTitle, for: .normal)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        rightBtn.backgroundColor = .black
        rightBtn.layer.cornerRadius = 8
        rightBtn.layer.masksToBounds = true
        rightBtn.titleLabel?.font = .font(size: 16, weight: .thin)
        contentV.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-item_x)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerY.equalTo(lineLabel)
        }
    }
    
    @objc func leftBtnClick() {
        self.leftblock!()
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
        }
    }
       
    @objc func rightBtnClick() {
        self.rightblock!()
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 设置界面
extension CustomAlertView {
    func setupUI() {
        
        
    }
}
