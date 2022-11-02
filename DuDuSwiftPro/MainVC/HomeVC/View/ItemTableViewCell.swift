//
//  ItemTableViewCell.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 4/25/22.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    let titleArr = ["RXSwift","闭包","SwiftUI","UDID","三方库","面试题","GIF","英语"]
    let imgArr = ["compute_home","yule_home","renwen_home","dili_home","yingshi_home","qiche_home","jianshen_home","zhonghua_home"]
    weak var delegate : ItemTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.createCellUI()
    }

    func createCellUI(){
        for i in 0...7 {
            let colunm = i%4;
            let row = i/4;
            let btnWidth = (screenWidth - 80)/4;
            let btnHeight = 65.0
            let itemBtn = LLButton.init(type: .custom)
            itemBtn.imageAlignment = .top
            itemBtn.frame = CGRect.init(x: 10 + CGFloat(colunm) * (btnWidth+20), y: 10 + CGFloat(row) * (btnHeight+20), width: btnWidth, height: btnHeight)
            itemBtn.setTitle(self.titleArr[i], for: .normal)
            itemBtn.tag = i + 100
            itemBtn.titleLabel?.font = .systemFont(ofSize: 11)
            itemBtn.setTitleColor(.black, for: .normal)
            itemBtn.addTarget(self, action: #selector(itemBtnClick(_:)), for: .touchUpInside)
            itemBtn.setImage(UIImage.init(named: self.imgArr[i]), for: .normal)
            contentView.addSubview(itemBtn)
        }
    }
}

extension ItemTableViewCell{
    @objc func itemBtnClick(_ btn: UIButton) {
        delegate?.itemBtnClick(btn.tag)
    }
}

protocol ItemTableViewCellDelegate: AnyObject {
    func itemBtnClick(_ indexItem : Int)
}
