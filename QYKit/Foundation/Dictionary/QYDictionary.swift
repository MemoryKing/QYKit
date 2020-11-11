/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation

public extension Dictionary {
    ///json 初始化
    init? (json: String) {
        if let data = (try? JSONSerialization.jsonObject(with: json.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary {
            self.init(_immutableCocoaDictionary: data)
        } else {
            self.init()
            return nil
        }
    }
    ///转json
    func yi_toJSONString(_ options: JSONSerialization.WritingOptions = []) -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            QYLog("dic转json失败")
            return nil
        }
        if let newData : Data = try? JSONSerialization.data(withJSONObject: self, options: options) {
            let JSONString = NSString(data:newData as Data,encoding: String.Encoding.utf8.rawValue)
            return JSONString as String? ?? nil
        }
        QYLog("dic转json失败")
        return nil
    }
    
    /// 字典转二进制
    func yi_toData(_ options: JSONSerialization.WritingOptions = .prettyPrinted) -> Data? {
        
        if (!JSONSerialization.isValidJSONObject(self)) {
            QYLog("字典转二进制失败")
            return Data()
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: options)
            return data
        } catch let error {
            QYLog(error)
        }
        return nil
    }
}
