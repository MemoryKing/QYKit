/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit
import Foundation
import CommonCrypto

//MARK: --- 初始化
public extension String {
    ///float -> string
    init(_ float: Float?) {
        self.init(String(describing: float ?? 0))
    }
    ///base64
    init ? (base64: String) {
        let pad = String(repeating: "=", count: base64.length % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }
}
//MARK: --- 功能
public extension String {
    //MARK: --- 异或
    ///异或
    func yi_xor (_ pinV: String) -> String {
        if self.count != pinV.count {
            QYLog("长度不匹配")
            return ""
        }
        var code = ""
        for i in 0 ..< self.length {
            let pan = self.yi_index(i, 1)
            let pin = pinV.yi_index(i, 1)
            let codes = self.creator(pan, pin)
            code = code + codes
        }
        return code
    }
    private func creator (_ pan: String,_ pin: String) -> String {
        var code = ""
        for i in 0 ..< pan.length {
            let pans = charToint(pan.utf8CString[i])
            let pins = charToint(pin.utf8CString[i])
            code = code.appendingFormat("%X", pans^pins)
        }
        return code
    }
    private func charToint (_ char: CChar) -> Int {
        if (char >= "0".utf8CString[0] && char <= "9".utf8CString[0]) {
            return Int(char) - Int("0".utf8CString[0])
        } else if (char >= "A".utf8CString[0] && char <= "F".utf8CString[0]) {
            return Int(char) - Int("A".utf8CString[0]) + 10
        } else if (char >= "a".utf8CString[0] && char <= "f".utf8CString[0]) {
            return Int(char) - Int("a".utf8CString[0]) + 10
        }
        return 0;
    }
    //MARK: --- 获取文本高度
    /// 获取文本高度
    func getHeight(_ font : UIFont = UIFont.systemFont(ofSize: 18), fixedWidth : CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            return 0
        }
        let size = CGSize(width:fixedWidth, height:CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context:nil)
        return rect.size.height
    }
    //MARK: --- 获取文本宽度
    /// 获取文本宽度
    func getWidth(_ font : UIFont = UIFont.systemFont(ofSize: 17)) -> CGFloat {
        guard self.count > 0 else {
            return 0
        }
        let size = CGSize(width:CGFloat.greatestFiniteMagnitude, height:0)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context:nil)
        return rect.size.width
    }
}
//MARK: --- 截取  插入  删除  添加
public extension String {
    ///开始结束
    func yi_index(_ start: Int ,_ stop: Int) -> String {
        let index1 = self.index(self.startIndex, offsetBy: start)
        let index2 = self.index(self.startIndex, offsetBy: stop)
        return String(self[index1..<index2])
    }
    ///开始到i
    func yi_index(to i: Int) -> String {
        let index = self.index(startIndex, offsetBy: i)
        return String(self[index])
    }
    ///截取range
    func yi_index(_ range: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: range.lowerBound)
        let end = self.index(startIndex, offsetBy: range.upperBound)
        return String(self[start..<end])
    }
    ///截取closedrange
    func yi_index(closedRange: ClosedRange<Int>) -> String {
        return self.yi_index(closedRange.lowerBound..<(closedRange.upperBound + 1))
    }
    ///count
    var length: Int {
        return self.count
    }
    ///替换指定范围内的字符串
    mutating func yi_replacing(index:Int,length:Int,replac:String) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: index)
        self.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: length), with: replac)
        return self
    }
    ///删除第一个字符
    mutating func yi_deleteFirst() -> String {
        self.remove(at: self.index(before: self.startIndex))
        return self
    }
    ///删除最后一个字符
    mutating func yi_deleteLast() -> String {
        self.remove(at: self.index(before: self.endIndex))
        return self
    }
    /// 删除指定字符串
    mutating func yi_delete(_ string: String) -> String {
        return self.replacingOccurrences(of: string, with: "")
    }
    /// 字符的插入
    mutating func yi_insert(_ text: Character, index: Int) -> String{
        let start = self.index(self.startIndex, offsetBy: index)
        self.insert(text, at: start)
        return self
    }
    ///字符串的插入
    mutating func yi_insert(_ text: String, index: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: index)
        self.insert(contentsOf: text, at: start)
        return self
    }
    /// 将字符串通过特定的字符串拆分为字符串数组
    func yi_components(_ string: String) -> [String] {
        return NSString(string: self).components(separatedBy: string)
    }
    ///去除前后的换行和空格
    func yi_removeSapce() -> String {
        var resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }
    ///获取某个字符串在总字符串的位置
    func yi_positionOf(_ sub: String,_ backwards: Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
}

//MARK: --- 转换
public extension String {
    /// Int
    func yi_toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    /// Double
    func yi_toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    /// Float
    func yi_toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    /// Bool
    func yi_toBool() -> Bool? {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    ///string --> date
    func yi_toDate(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss",_ timeZone: TimeZone = NSTimeZone.system) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        let date = formatter.date(from: self)
        return date!
    }
    ///string --> date
    func yi_toDate(_ dateFormat: QYDateFormatter = .dateModeYMDHMS,_ timeZone: TimeZone = NSTimeZone.system) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat.rawValue
        formatter.timeZone = timeZone
        let date = formatter.date(from: self)
        return date!
    }
    /// 字符串转时间戳
    func yi_toStampTime(_ mode: QYDateFormatter = .dateModeYMDHMS) -> Int {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = mode.rawValue
        let current = dateFormatter.date(from: self)
        let date = Date.init(timeInterval: 0, since: current ?? Date())
        let stamp = date.timeIntervalSince1970
        return Int(stamp)
    }
    /// JSONString转换为字典
    func yi_toDictionary() -> NSDictionary {
        let jsonData:Data = self.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    ///十六进制转数字
    func yi_hexToInt() -> Int {
        let str = self.uppercased()
        var sum = 0
        for i in str.utf8 {
            // 0-9 从48开始
            sum = sum * 16 + Int(i) - 48
            // A-Z 从65开始，但有初始值10，所以应该是减去55
            if i >= 65 {
                sum -= 7
            }
        }
        return sum
    }
    ///十六进制转换为普通字符串
    func yi_hexToString() -> String {
        var bytes = [UInt8]()
        var dataBStr: String = ""
        for (index, _) in self.enumerated(){
            let fromIndex = index * 2
            let toIndex = index * 2 + 1
            if toIndex > (self.count - 1) {
                break
            }
            let hexCharStr = self.yi_index(fromIndex, 2)
            var r:CUnsignedInt = 0
            Scanner(string: hexCharStr).scanHexInt32(&r)
            bytes.append(UInt8(r))
        }
        dataBStr = String.init(data: Data(bytes), encoding: String.Encoding.ascii)!
        return dataBStr
    }
    ///普通字符串转换为十六进制
    func yi_toHexString() -> String {
        let strData = self.data(using: String.Encoding.utf8)
        let bytes = [UInt8](strData!)
        var sumString: String = ""
        for byte in bytes {
            let newString = String(format: "%x",byte&0xff)
            if newString.count == 1 {
                sumString = String(format: "%@0%@",sumString,newString)
            }else{
                sumString = String(format: "%@%@",sumString,newString)
            }
        }
        return sumString
    }
    /// base64
    func yi_toBase64 (_ options: Data.Base64EncodingOptions = [.lineLength64Characters]) -> String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: options)
        return base64String
    }
    ///转成byte数组
    func yi_toBytes() -> [UInt8] {
        let strData = self.data(using: String.Encoding.utf8)! as NSData
        let count = self.count / MemoryLayout<UInt8>.size
        var bytesArray = [UInt8](repeating: 0, count: count)
        strData.getBytes(&bytesArray, length:count * MemoryLayout<UInt8>.size)
        return bytesArray
    }
    ///url
    func yi_toUrl() -> URL? {
        return URL(string: self)
    }
    ///图片
    func yi_toUrlImage() -> UIImage? {
        var image: UIImage?
        let url = URL.init(string: self)
        do {
            let data = try Data(contentsOf: url!)
            image = UIImage.init(data: data)
        }catch let error as NSError {
            print(error)
        }
        return image
    }
    ///md5 字符串加密
    func yi_md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    ///NSAttributedString
    func yi_toAttributed() -> NSAttributedString {
        return NSAttributedString.init(string: self)
    }
    
}
//MARK: --- 大小写
public extension String {
    ///转为大写
    func yi_uppercased(_ locale: Locale?) -> String {
        return self.uppercased(with: locale)
    }
    ///转为小写
    func yi_lowercased(_ locale: Locale?) -> String {
        return self.lowercased(with: locale)
    }
    ///大写字符串的第“计数”字符
    mutating func yi_uppercasePrefix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        self.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                             with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).uppercased())
    }
    ///大写首'计数'字符的字符串
    func yi_uppercasedPrefix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).uppercased())
        return result
    }
    ///字符串的最后“计数”字符，返回一个新字符串
    func yi_uppercasedSuffix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(self.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                               with: String(self[self.index(endIndex, offsetBy: -min(count, length))..<endIndex]).uppercased())
        return result
    }
    ///范围内大写
    func yi_uppercased(range: CountableRange<Int>) -> String {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard self.count > 0 && (0..<length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to),
                               with: String(self[self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to)]).uppercased())
        return result
    }
    ///首字母小写
    func yi_lowercasedFirst() -> String {
        guard self.count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).lowercased())
        return result
    }
    ///小写字符串的第一个“计数”字符
    func yi_lowercasedPrefix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).lowercased())
        return result
    }
    ///字符串的最后“计数”字符小写
    func yi_lowercasedSuffix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(self.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                               with: String(self[self.index(endIndex, offsetBy: -min(count, length))..<endIndex]).lowercased())
        return result
    }
    
}
