/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/
 

import Foundation

extension Data {
    ///byte  unit8 数组
    var yi_bytes: [UInt8] {
        return [UInt8](self)
    }
    ///转string
    func yi_toString(_ encoding: String.Encoding = String.Encoding.utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    ///json对象
    func yi_toJsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
    /// data转数组
    func yi_toArray() -> Array<Any> {
        let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        let array = json as! Array<Any>
        return array
    }
    /// 转字典
    func yi_toDictionary() -> Dictionary<String, Any> {
        let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        let dic = json as! Dictionary<String, Any>
        return dic
    }
}
