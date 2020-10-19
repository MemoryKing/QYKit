/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit
import Foundation

public protocol QYMappable: Codable {

}

public extension QYMappable {

    ///model 转 json
    func yi_toJSONString () -> String? {
        if let jsonData = try? JSONEncoder().encode(self) {
            // 编码成功，将 jsonData 转为字符输出查看
            if let jsonString = String.init(data: jsonData, encoding: String.Encoding.utf8) {
                QYLog("jsonString:" + "\(jsonString)")
                return jsonString
            }
        }
        QYLog("model转换失败")
        return nil
    }
    
    
    
    
}
