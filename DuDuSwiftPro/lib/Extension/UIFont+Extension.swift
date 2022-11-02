//
//  UIFont+Extension.swift
//  FeedsPro
//
//  Created by HY on 2021/12/28.
//

import Foundation
import UIKit

// 字体宽度枚举
enum fontWeight {
    case thin
    case regular
    case medium
    case semibold
    case bold
    
    @available(iOS 8.2, *)
    func systemWeight() -> UIFont.Weight {
        switch self {
        case .thin:
            return UIFont.Weight.thin
        case .regular:
            return UIFont.Weight.regular
        case .medium:
            return UIFont.Weight.medium
        case .semibold:
            return UIFont.Weight.semibold
        case .bold:
            return UIFont.Weight.bold
        }
    }
}

// UIFont + Extension
extension UIFont {
     
    /// 系统字体，默认字号16，Weight为regular
    class func font(size: CGFloat = 16, weight: fontWeight = .regular) -> UIFont! {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: size, weight: weight.systemWeight())
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}


//extension UIFont {
//    public enum fontType: Int {
//        case Thin
//        case Medium
//        case Black
//        case Light
//        case Bold
//        case Regular
//        case Gotham_Bold
//    }
//
//    open class func customFont( size: CGFloat, type: fontType = .Regular) -> UIFont {
//        let font = UIFont(name: getFontName(type: type), size: size)
//        if font != nil {
//            return font!
//        }else {
//            return .systemFont(ofSize: size)
//        }
//    }
//
//    open class func getFontName(type: fontType = .Regular) -> String {
//        switch type {
//        case .Thin:
//            return "NotoSansSC-Thin"
//        case .Medium:
//            return "NotoSansSC-Medium"
//        case .Black:
//            return "NotoSansSC-Black"
//        case .Light:
//            return "NotoSansSC-Light"
//        case .Bold:
//            return "NotoSansSC-Bold"
//        case .Regular:
//            return "NotoSansSC-Regular"
//        case .Gotham_Bold:
//            return "Gotham-Bold"
//        }
//    }
//
//}
