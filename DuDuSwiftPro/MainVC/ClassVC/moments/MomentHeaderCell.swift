//
//  MomentHeaderCell.swift
//  mooc
//
//  Created by Jerome Xiong on 2020/4/14.
//  Copyright © 2020 kilomind. All rights reserved.
//

import Kingfisher

/// 多张图片显示
class MomentHeaderCell: UICollectionViewCell {
    static let padding: CGFloat = 16
    static let contentLeft = padding+10+50
    static let contentW = screenWidth-padding-contentLeft
    fileprivate lazy var avatarIV: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: MomentHeaderCell.padding, y: 10, width: 50, height: 50)
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(previewImage(_:)))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    fileprivate lazy var usernameLb: UILabel = {
        let lb = UILabel()
        lb.frame = CGRect(x: avatarIV.frame.maxX+10, y: avatarIV.frame.minY+2, width: MomentHeaderCell.contentW, height: 20)
        lb.textColor = mCoverColor
        lb.font = UIFont.boldSystemFont(ofSize: 17)
        return lb
    }()
    fileprivate lazy var contentLb: JXLabel = {
        let lb = JXLabel()
        lb.frame = CGRect(x: usernameLb.frame.minX, y: usernameLb.frame.maxY+5, width: MomentHeaderCell.contentW, height: 0)
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.numberOfLines = 0
        lb.showFavor = {[weak self] in
            guard let self = self else { return }
        }
        return lb
    }()
    fileprivate lazy var expendBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("展开", for: .normal)
        btn.setTitle("收起", for: .selected)
        btn.setTitleColor(.blue, for: .normal)
        btn.setTitleColor(.blue, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        btn.sizeToFit()
        btn.isHidden = true
        return btn
    }()
    fileprivate lazy var nineImageView: NineImageView = {
        let view = NineImageView(frame: .zero)
        view.frame = contentLb.frame
        view.frame.size.width -= 50
        view.onPreviewImages = {[weak self] indexPath in
        }
        return view
    }()
    
    var onClick: ((Int)->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var viewModel: MomentInfo?
}
extension MomentHeaderCell {
    func setup() {
        addSubview(avatarIV)
        addSubview(usernameLb)
        addSubview(contentLb)
        addSubview(expendBtn)
        addSubview(nineImageView)
        setLabel()
    }
    func setLabel() {
        contentLb.enabledTypes = [.URL, .phone]
        contentLb.handleURLTap { (text) in
            NotificationCenter.default.post(name: NSNotification.Name.list.openURL, object: URL(string: text))
        }
        contentLb.handlePhoneTap { (phone) in
            UIApplication.shared.openURL(URL(string: "tel://\(phone)")!)
        }
    }
    @objc func previewImage(_ ges: UIGestureRecognizer) {
        switch ges.view?.tag {
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name.list.push, object: viewModel?.userInfo)
        default:
            break
        }
    }
    @objc func click(_ btn: UIButton) {
        onClick?(btn.tag)
    }
}
extension MomentHeaderCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? MomentInfo else { return }
        self.viewModel = viewModel
        avatarIV.kf.setImage(with: URL(string: viewModel.avatar))
        usernameLb.text = viewModel.userName
        
        contentLb.text = viewModel.content
        contentLb.frame.size.height = viewModel.textHeight
        
        if viewModel.isNeedExpend {
            expendBtn.isSelected = viewModel.isTextExpend
            contentLb.numberOfLines = viewModel.isTextExpend ? 0 : 3
            expendBtn.frame.origin = CGPoint(x: contentLb.frame.minX, y: contentLb.frame.maxY)
        }
        expendBtn.isHidden = !viewModel.isNeedExpend
        
        // 不能通过if判断切换同一位置的显示视图
        if viewModel.images.count > 0 {
            let maxY = contentLb.frame.maxY + 10 + (!expendBtn.isHidden ? expendBtn.frame.height : 0)
            nineImageView.images = viewModel.images
            nineImageView.frame.origin.y = maxY
            nineImageView.frame.size.height = viewModel.momentPicsHeight(viewModel.images.count)
        }else {
            nineImageView.frame.size.height = 0
        }
    }
}
