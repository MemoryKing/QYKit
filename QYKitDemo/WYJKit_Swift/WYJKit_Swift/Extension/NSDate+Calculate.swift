/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation

public extension Date {
    ///时间格式转换
    func formatter (_ formatter : String?) -> String {
        let date = Date.init()
        let fora = DateFormatter.init()
        fora.dateFormat = formatter
        return fora.string(from: date)
    }
}

///时间格式转换
public func WDateformatter (_ date : Date, _ formatter : String) -> String {
    let fora = DateFormatter.init()
    fora.dateFormat = formatter
    return fora.string(from: date)
}
