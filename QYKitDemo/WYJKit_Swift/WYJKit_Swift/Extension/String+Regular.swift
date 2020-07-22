/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit

//MARK: ---------- 正则 ----------
public extension String {
    
    ///匹配手机号
    var isPhone : Bool {
        get {
            let regex = "^1(3[0-9]|4[56789]|5[0-9]|6[6]|7[0-9]|8[0-9]|9[89])\\d{8}$"
            return self.regexPatternResultWithRegex(regex, self)
        }
    }
    
    ///正则
    func regexPatternResultWithRegex (_ regex : String, _ targetString : String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch : Bool = predicate.evaluate(with: targetString)
        return isMatch
    }
}
