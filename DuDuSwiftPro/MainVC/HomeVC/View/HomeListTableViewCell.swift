//
//  HomeListTableViewCell.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 4/26/22.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var items = NSDictionary(){
        didSet {
            let img = items["back_img"]
            let path = "\(BASE_URL)" + "\(img ?? "")"
            self.commentImgv.kf.setImage(with: URL(string: path),placeholder: UIImage.init(named: "person_head"))
            self.titleLabel.text = items["title"] as? String
            self.contentLabel.text = items["content"] as? String
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        contentView.backgroundColor = .white
        self.createCellUI()
    }
    
    

    func createCellUI()  {
        contentView.addSubview(self.backView)
        self.backView.addSubview(self.commentImgv)
//        self.backView.addSubview(self.timeLabel)
        self.backView.addSubview(self.titleLabel)
        self.backView.addSubview(self.contentLabel)

        
        self.backView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
        self.commentImgv.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(self.backView)
            make.width.equalTo(120)
        }
        
//        self.timeLabel.snp.makeConstraints { make in
//            make.right.equalTo(self.commentImgv).offset(-10)
//            make.top.equalTo(self.commentImgv.snp.bottom).offset(10)
//            make.height.equalTo(18)
//            make.width.equalTo(220)
//        }
//
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.commentImgv.snp.right).offset(3)
            make.right.equalTo(self.backView)
            make.top.equalTo(self.backView)
            make.height.equalTo(20)
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(2)
            make.left.equalTo(self.commentImgv.snp.right).offset(3)
            make.right.equalTo(self.backView)
            make.bottom.equalTo(self.backView).offset(-8)
        }
    }
    
    var contentLabel : UILabel = {
        let contentLabel = UILabel.init()
        contentLabel.textColor = .black
        contentLabel.font = .systemFont(ofSize: 12)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    var timeLabel : UILabel = {
        let timeLabel = UILabel.init()
        timeLabel.textColor = ColorFromString(hex: "#999999")
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textAlignment = .right
        return timeLabel
    }()
    
    var titleLabel : UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.textColor = .gray
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.text = "我是标题"
        return titleLabel
    }()
    
    var backView : UIView = {
        let backView = UIView.init()
        backView.backgroundColor = ColorFromString(hex: "#FFFFFF")
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 5
        backView.layer.borderWidth = 0.3
        backView.layer.borderColor = ColorFromString(hex: "#999999").cgColor
        return backView
    }()
    
    var commentImgv : UIImageView = {
        let commentImgv = UIImageView.init()
        commentImgv.image = .init(named: "add_noRecommend_640")
        commentImgv.layer.masksToBounds = true
        commentImgv.layer.cornerRadius = 5
        return commentImgv
    }()
}
