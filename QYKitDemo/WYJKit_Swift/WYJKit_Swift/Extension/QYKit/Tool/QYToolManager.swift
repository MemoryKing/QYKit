/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit

class QYToolManager: NSObject {
    
}

/**
 字典转换为JSONString
 
 - parameter dictionary: 字典参数
 
 - returns: JSONString
 */
public func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        print("无法解析出JSONString")
        return ""
    }
    let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}
/// JSONString转换为字典
///
/// - Parameter jsonString
/// - Returns: 字典
public func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{

    let jsonData:Data = jsonString.data(using: .utf8)!

    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
}

public func QYPrintLog<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
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
