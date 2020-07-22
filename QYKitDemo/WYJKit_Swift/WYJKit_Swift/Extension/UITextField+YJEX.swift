/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import UIKit

public extension UITextField {
    struct RuntimeKey {
        static let placeholderColorKey = UnsafeRawPointer.init(bitPattern: "placeholderColor".hashValue)
        static let maximumLimitKey = UnsafeRawPointer.init(bitPattern: "maximumLimit".hashValue)
        static let addNotiKey = UnsafeRawPointer.init(bitPattern: "addNoti".hashValue)
    }
    
    var placeholderColor : UIColor {
        set {
            objc_setAssociatedObject(self, RuntimeKey.placeholderColorKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            let arrt = NSMutableAttributedString.init(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : newValue])
            attributedPlaceholder = arrt
        }
        get {
            return objc_getAssociatedObject(self, RuntimeKey.placeholderColorKey!) as! UIColor
        }
    }
}
