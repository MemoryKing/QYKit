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
    func yi_toJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            return String(jsonStr ?? "")
        }
        return nil
    }
    /// 字典转二进制
    func yi_toData() -> Data {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("字典转二进制失败")
            return Data()
        }
        let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        return data!
    }
}
