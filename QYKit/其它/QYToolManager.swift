/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit

class QYToolManager: NSObject {
    
}

//MARK: --- 设置别名
///设置别名
public typealias Byte  = Int8
public typealias Short = Int16
public typealias Long  = Int64

//MARK: --- 打印
///打印
public func QYLog<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
    //获取当前时间
    let now = Date()
    //创建一个日期格式器
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    //要把路径最后的字符串截取出来
    let lastName = ((fileName as NSString).pathComponents.last!)
    print("debug--\(dformatter.string(from: now)) [\(lastName)][第\(lineNumber)行] -- \(message)")
    
    #endif
}
