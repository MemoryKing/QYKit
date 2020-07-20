/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit
import Foundation

//MARK: -------   初始化
extension String {
    
    ///float -> string
    init(_ float : Float?) {
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
extension String {
    ///去除前后的换行和空格
    public func yi_removeTrimming () -> String {
        var resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }
}
extension String {
    ///截取
    public func yi_index(_ start : Int = 0, _ stop : Int) -> String {
        let index1 = self.index(self.startIndex, offsetBy: start)
        let index2 = self.index(self.startIndex, offsetBy: stop)
        return String(self[index1..<index2])
    }
    public func yi_index(_ start : Int = 0, by : Int) -> String {
        let index1 = self.index(self.startIndex, offsetBy: start)
        let index2 = self.index(self.startIndex, offsetBy: start + by)
        return String(self[index1..<index2])
    }
    ///开始到结束
    public func yi_index(_ integerIndex: Int) -> Character {
        let index = self.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }
    ///range
    public func yi_index(_ integerRange: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = self.index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start..<end])
    }
    
    ///closedrange
    public func yi_index(integerClosedRange: ClosedRange<Int>) -> String {
        return self.yi_index(integerClosedRange.lowerBound..<(integerClosedRange.upperBound + 1))
    }
    
    ///Character count
    public var length: Int {
        return self.count
    }
}

//MARK: -------   转换
extension String {
    ///替换
    public func yi_replace(text : String,start: Int,stop:Int) -> String{
        if self.count == 0 {
            return ""
        }
        let beginString = (self as NSString).substring(to: start)
        let stopString = (self as NSString).substring(from: stop)
        return beginString + text + stopString
    }
    ///string --> date
    public func yi_toDate(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss",_ timeZone : TimeZone = NSTimeZone.system) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        let date = formatter.date(from: self)
        return date!
    }
    /// JSONString转换为字典
    public func yi_toDictionary() -> NSDictionary {
        let jsonData:Data = self.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    /// base64
    public func yi_toBase64 (_ options : Data.Base64EncodingOptions = [.lineLength64Characters]) -> String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: options)
        return base64String
    }
    /// Int
    public func yi_toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// Double
    public func yi_toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// Float
    public func yi_toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// Bool
    public func yi_toBool() -> Bool? {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    ///十六进制转数字
    public func yi_hexToInt() -> Int {
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
    public func yi_hexToString() -> String {
        var bytes = [UInt8]()
        var dataBStr : String = ""
        for (index, _) in self.enumerated(){
            let fromIndex = index*2
            let toIndex = index*2 + 1
            if toIndex > (self.count - 1) {
                break
            }
            let hexCharStr = self.yi_index(fromIndex, by: 2)
            var r:CUnsignedInt = 0
            Scanner(string: hexCharStr).scanHexInt32(&r)
            bytes.append(UInt8(r))
        }
        dataBStr = String.init(data: Data(bytes), encoding: String.Encoding.ascii)!
        return dataBStr
    }
    ///普通字符串转换为十六进制
    public func yi_toHexString() -> String {
        let strData = self.data(using: String.Encoding.utf8)
        let bytes = [UInt8](strData!)
        var sumString : String = ""
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
    ///转成byte数组
    public func yi_toBytes () -> [UInt8] {
        let strData = self.data(using: String.Encoding.utf8)
        let bytes = [UInt8](strData!)
        return bytes
    }
    ///url
    public var yi_url: URL? {
        return URL(string: self)
    }
    ///图片
    public var urlImage : UIImage? {
        var image : UIImage?
        let url = URL.init(string: self)
        do {
            let data = try Data(contentsOf: url!)
            image = UIImage.init(data: data)
        }catch let error as NSError {
            print(error)
        }
        return image
    }
}
//MARK: -------   大小写
extension String {
    ///大写字符串的第一个“计数”字符
    public mutating func yi_uppercasePrefix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        self.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                             with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).uppercased())
    }
    
    ///大写首'计数'字符的字符串，返回一个新的字符串
    public func yi_uppercasedPrefix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).uppercased())
        return result
    }
    
    ///字符串的最后一个“计数”字符是大写的
    public mutating func yi_uppercaseSuffix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        self.replaceSubrange(self.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                             with: String(self[self.index(endIndex, offsetBy: -min(count, length))..<endIndex]).uppercased())
    }
    
    ///字符串的最后一个“计数”字符，返回一个新字符串
    public func yi_uppercasedSuffix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(self.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                               with: String(self[self.index(endIndex, offsetBy: -min(count, length))..<endIndex]).uppercased())
        return result
    }
    
    ///范围内大写
    public mutating func yi_uppercase(range: CountableRange<Int>) {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard self.count > 0 && (0..<length).contains(from) else { return }
        self.replaceSubrange(self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to),
                             with: String(self[self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to)]).uppercased())
    }
    
    ///范围内大写
    public func yi_uppercased(range: CountableRange<Int>) -> String {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard self.count > 0 && (0..<length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to),
                               with: String(self[self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to)]).uppercased())
        return result
    }
    
    ///首字母小写
    public mutating func yi_lowercaseFirst() {
        guard self.count > 0 else { return }
        self.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).lowercased())
    }
    
    ///首字母小写
    public func yi_lowercasedFirst() -> String {
        guard self.count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).lowercased())
        return result
    }
    
    ///字符串的小写首'计数'字符
    public mutating func yi_lowercasePrefix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        self.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                             with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).lowercased())
    }
    
    ///小写字符串的第一个“计数”字符
    public func yi_lowercasedPrefix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).lowercased())
        return result
    }
    
    ///字符串的最后“计数”字符小写
    public mutating func yi_lowercaseSuffix(_ count: Int) {
        guard self.count > 0 && count > 0 else { return }
        self.replaceSubrange(self.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                             with: String(self[self.index(endIndex, offsetBy: -min(count, length))..<endIndex]).lowercased())
    }
    
    ///字符串的最后“计数”字符小写
    public func yi_lowercasedSuffix(_ count: Int) -> String {
        guard self.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(self.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                               with: String(self[self.index(endIndex, offsetBy: -min(count, length))..<endIndex]).lowercased())
        return result
    }
    
}
