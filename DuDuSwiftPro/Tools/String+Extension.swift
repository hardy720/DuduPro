//
//  String+Extension.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 10/29/22.
//

import Foundation

extension String {
    var StrIsBlank:Bool{
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return str.isEmpty
    }
    
    ///验证邮箱
    func isValidEmailStricterFilter() -> Bool {
        if self.count == 0 {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func getTextHeigh(font : UIFont, width : CGFloat)  -> CGFloat{
            let normalText : NSString = self as NSString
        let size = CGSize(width: width, height:CGFloat(MAXFLOAT))   //CGSizeMake(width,1000)
            let dic = NSDictionary(object: font, forKey : kCTFontAttributeName as! NSCopying)
            let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
            return  stringSize.height
    }
}

