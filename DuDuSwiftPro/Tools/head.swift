//
//  head.swift
//  SwiftPro
//
//  Created by 夕阳西下 on 2020/6/19.
//  Copyright © 2020 夕阳西下. All rights reserved.
//




import UIKit
import Foundation
import SnapKit

class head: NSObject {

}

let BASE_URL = "http://localhost:8080/DuDuChat_Web_exploded/"

let LOADCOUNT = "3"

let TOASTSHOWTIME = 2


let device_id: Int = 6096495334
let iid: Int = 5034850950


//设备宽高、机型
/// 屏幕的宽度
let screenWidth = UIScreen.main.bounds.width
/// 屏幕的高度
let screenHeight = UIScreen.main.bounds.height
let HomeIndicator = CGFloat(kIsIphoneX ? 34 : 0)
let kMyHeaderViewHeight:CGFloat = 280
let isNight = "isNight"
/// 关注的用户详情界面 topTab 的指示条的宽度 和 高度
let topTabindicatorWidth: CGFloat = 40
let topTabindicatorHeight: CGFloat = 2
let mImageW = (screenWidth - 156) / 3



/// 关注的用户详情界面 topTab 的按钮的宽度
let topTabButtonWidth: CGFloat = screenWidth * 0.2


//keyWindow
let KeyWindow = UIApplication.shared.keyWindow

//判断是否iphone
let kIsIphone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

//判断是否iphone x
let kIsIphoneX = Bool(screenWidth >= 375.0 && screenHeight >= 812.0 && kIsIphone)

//判断是否为MacOSX
@available(iOS 13.0, *)
let isRunningOnMacOSX = ProcessInfo.processInfo.isMacCatalystApp


//导航条高度
let kNavigationBarH = CGFloat(kIsIphoneX ? 88 : 64)
let mNavigationBarH: CGFloat = 44
let mTopHeight: CGFloat = mNavigationBarH + kStatusBarH
//状态栏高度
//let kStatusBarH = CGFloat(kIsIphoneX ? 44 : 20)

/// 状态栏高度
var kStatusBarH: CGFloat {
    if #available(iOS 13.0, *) {
        guard let statusbar = UIApplication.shared.windows.first?.windowScene?.statusBarManager else {
            return 0
        }
        return statusbar.statusBarFrame.size.height
    } else {
        return UIApplication.shared.statusBarFrame.size.height
    }
}

let mCoverColor = RGBColor(r: 104, g: 114, b: 140)
let mBlackColor = UIColor.jx_color(hex: "#444444")
let mDarkBlueColor = UIColor.jx_color(hex: "#375793")

//自定义颜色
func RGBColor(r :CGFloat, g : CGFloat, b : CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
/*
 * 16进制颜色
 *
 */
public func ColorFromString (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}

let NavBackColor = RGBColor(r: 87, g: 140, b: 169)

let ThemeColor = RGBColor(r: 67.0, g: 255.0, b: 222)

let BackColor = RGBColor(r: 241, g: 243, b: 248)

//字号
func customFont(font: CGFloat) -> UIFont {
    //刘海屏
    guard screenHeight <= 736 else {
        return UIFont.systemFont(ofSize: font)
    }
    
    //5.5
    guard screenHeight == 736 else {
        return UIFont.systemFont(ofSize: font-2)
    }
    
    //4.7
    guard screenHeight >= 736 else {
        return UIFont.systemFont(ofSize: font-1)
    }
    return UIFont.systemFont(ofSize: font)
}

func fStringIsEmpty(value: AnyObject?) -> Bool {
    //首先判断是否为nil
    if (nil == value) {
        //对象是nil，直接认为是空串
        return true
    }else{
        //然后是否可以转化为String
        if let myValue  = value as? String{
            //然后对String做判断
            return myValue == "" || myValue == "(null)" || 0 == myValue.count
        }else{
            //字符串都不是，直接认为是空串
            return true
        }
    }
}

//value 是AnyObject类型是因为有可能所传的值不是String类型，有可能是其他任意的类型。
func StringIsEmpty(value: AnyObject?) -> Bool {
    //首先判断是否为nil
    if (nil == value) {
        //对象是nil，直接认为是空串
        return true
    }else{
        //然后是否可以转化为String
        if let myValue  = value as? String{
            //然后对String做判断
            return myValue == "" || myValue == "(null)" || 0 == myValue.count
        }else{
            //字符串都不是，直接认为是空串
            return true
        }
    }
}



/// 动态图片的宽高
// 图片的宽高
// 1        screenWidth * 0.5
// 2        (screenWidth - 35) / 2
// 3,4,5-9    (screenWidth - 40) / 3
let image1Width: CGFloat = screenWidth * 0.5
let image2Width: CGFloat = (screenWidth - 35) * 0.5
let image3Width: CGFloat = (screenWidth - 40) / 3
let NavigationBarConcernButtonClicked = "NavigationBarConcernButtonClicked"

let kUserDetailHeaderBGImageViewHeight: CGFloat = 146

extension NSObject {
    /// 返回类名
    static var jx_className: String {
        get {
            let a = NSStringFromClass(self)
            let className = a.split(separator: ".").last
            return String(className!)
        }
    }
}


let keyWindow:UIWindow = {
    var window:UIWindow = UIApplication.shared.keyWindow!
    if #available(iOS 13.0, *) {
        window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).last!
    }
    return window
}()


public extension UIColor {
    /// 扩展UIColor 构造函数，直接传入RGB数据值即可，无需转换
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    /// 把颜色转成图片
    func jx_toImage(size: CGSize) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    var jx_hex: Int {
        let red = Int(self.jx_rgba.0 * 255) << 16
        let green = Int(self.jx_rgba.1 * 255) << 8
        let blue = Int(self.jx_rgba.2 * 255)
        return red+green+blue
    }
    var jx_rgba: (CGFloat, CGFloat, CGFloat, CGFloat) {
        let numberOfComponents = self.cgColor.numberOfComponents
        guard let components = self.cgColor.components else {
            return (0,0,0,1)
        }
        if numberOfComponents == 2 {
            return (components[0], components[0], components[0], components[1])
        }
        if numberOfComponents == 4 {
            return (components[0], components[1], components[2], components[3])
        }
        return (0,0,0,1)
    }
    ///类的计算型属性. 生成随机颜色
    static var jx_random: UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
    }
    ///16进制 转 RGBA
    static func jx_color(withHex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((withHex & 0xFF0000) >> 16)
        let green = CGFloat((withHex & 0xFF00) >> 8)
        let blue = CGFloat((withHex & 0xFF))
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    /// 16进制转UIColor
    static func jx_color(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        return proceesHex(hex: hex, alpha: alpha)
    }
}

//设备udid
func getIdentifierNumber()-> String {
    let retrievedString: String? = KeychainWrapper.standard.string(forKey: "myKeyy")
    if (retrievedString == nil) {
        let identifierNumber = (UIDevice.current.identifierForVendor?.uuidString)!
        let saveSuccessful: Bool = KeychainWrapper.standard.set(identifierNumber, forKey: "myKeyy")
        return identifierNumber
    }
    return retrievedString!
}

fileprivate extension UIColor {
    static func proceesHex(hex: String, alpha: CGFloat) -> UIColor {
        /** 如果传入的字符串为空 */
        if hex.isEmpty {
            return UIColor.clear
        }
        
        /** 传进来的值。 去掉了可能包含的空格、特殊字符， 并且全部转换为大写 */
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        var hHex = (hex.trimmingCharacters(in: whitespace)).uppercased()
        
        /** 如果处理过后的字符串少于6位 */
        if hHex.count < 6 {
            return UIColor.clear
        }
        
        /** 开头是用0x开始的  或者  开头是以＃＃开始的 */
        if hHex.hasPrefix("0X") || hHex.hasPrefix("##") {
            hHex = String(hHex.dropFirst(2))
        }
        
        /** 开头是以＃开头的 */
        if hHex.hasPrefix("#") {
            hHex = (hHex as NSString).substring(from: 1)
        }
        
        /** 截取出来的有效长度是6位， 所以不是6位的直接返回 */
        if hHex.count != 6 {
            return UIColor.clear
        }
        
        /** R G B */
        var range = NSMakeRange(0, 2)
        
        /** R */
        let rHex = (hHex as NSString).substring(with: range)
        
        /** G */
        range.location = 2
        let gHex = (hHex as NSString).substring(with: range)
        
        /** B */
        range.location = 4
        let bHex = (hHex as NSString).substring(with: range)
        
        /** 类型转换 */
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}


extension String {
    
    /// 获取文字的宽高 空字符串高度为字体高度
    ///
    /// - Parameters:
    ///   - maxWidth: 空间的最大宽度
    ///   - font: 文字字体
    /// - Returns: 返回计算好的size
    func textSize(_ maxWidth: CGFloat, font: UIFont) -> CGSize {
        let constraint = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: constraint, options: ([.usesLineFragmentOrigin]), attributes: [NSAttributedString.Key.font: font], context: nil)
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }
    
    /// 获取文字的每一行字符串 空字符串为空数组
    ///
    /// - Parameters:
    ///   - maxWidth: 空间的最大宽度
    ///   - font: 文字字体
    /// - Returns: 返回计算好的行字符串
    func textLines(_ maxWidth: CGFloat, font: UIFont) -> [String] {
        let myFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        
        let attStr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byCharWrapping
        
        attStr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attStr.length))
        attStr.addAttribute(NSAttributedString.Key(kCTFontAttributeName as String), value: myFont, range: NSRange(location: 0, length: attStr.length))
        let frameSetter = CTFramesetterCreateWithAttributedString(attStr)
        
        let path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width:maxWidth, height: 100000), transform: .identity)
        
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(CFIndex(0), CFIndex(0)), path, nil)
        let lines = CTFrameGetLines(frame) as? [AnyHashable]
        var linesArray: [String] = []
        
        for line in lines ?? [] {
            let lineRange = CTLineGetStringRange(line as! CTLine)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            
            let lineString = (self as NSString).substring(with: range)
            CFAttributedStringSetAttribute(attStr, lineRange, kCTKernAttributeName, (NSNumber(value: 0.0)))
            linesArray.append(lineString)
        }
        return linesArray
    }
}
