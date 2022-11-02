//
//  LLButton.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 4/25/22.
//

import UIKit

enum LLImageAlignment: NSInteger {
    case left = 0
    case top
    case bottom
    case right
}

class LLButton: UIButton {
    var imageAlignment: LLImageAlignment = .left
    var spaceBetweenTitleAndImage: CGFloat = 0
    override func layoutSubviews() {
        super.layoutSubviews()
            
        let space: CGFloat = self.spaceBetweenTitleAndImage
            
        let titleW: CGFloat = self.titleLabel?.bounds.width ?? 0
        let titleH: CGFloat = self.titleLabel?.bounds.height ?? 0
            
        let imageW: CGFloat = self.imageView?.bounds.width ?? 0
        let imageH: CGFloat = self.imageView?.bounds.height ?? 0
         
        let btnCenterX: CGFloat = self.bounds.width / 2
            let imageCenterX: CGFloat = btnCenterX - titleW / 2
            let titleCenterX = btnCenterX + imageW / 2
            
        switch self.imageAlignment {
        case .top:
                self.titleEdgeInsets = UIEdgeInsets(top: imageH / 2 + space / 2, left: -(titleCenterX - btnCenterX), bottom: -(imageH/2 + space/2), right: titleCenterX-btnCenterX)
                self.imageEdgeInsets = UIEdgeInsets(top: -(titleH / 2 + space / 2), left: btnCenterX - imageCenterX, bottom: titleH / 2 + space / 2, right: -(btnCenterX - imageCenterX));
            case .left:
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: -space / 2);
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2, bottom: 0, right: space);
            case .bottom:
                self.titleEdgeInsets = UIEdgeInsets(top: -(imageH / 2 + space / 2), left: -(titleCenterX - btnCenterX), bottom: imageH / 2 + space / 2, right: titleCenterX - btnCenterX);
                self.imageEdgeInsets = UIEdgeInsets(top: titleH / 2 + space / 2, left: btnCenterX - imageCenterX,bottom: -(titleH / 2 + space / 2), right: -(btnCenterX - imageCenterX));
            case .right:
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageW + space / 2), bottom: 0, right: imageW + space / 2);
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleW + space / 2, bottom: 0, right: -(titleW + space / 2));
            }
        }
}
