/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation

//MARK: --- 获取属性和方法
public extension NSObject {
    //MARK: --- 获取类的属性列表
    /// 获取类的属性列表
    func yi_get_class_copyPropertyList() -> [String] {
        var outCount:UInt32 = 0
        let propers:UnsafeMutablePointer<objc_property_t>! =  class_copyPropertyList(self.classForCoder, &outCount)
        let count:Int = Int(outCount);
        var names:[String] = [String]()
        for i in 0...(count-1) {
            let aPro: objc_property_t = propers[i]
            if let proName:String = String(utf8String: property_getName(aPro)){
                names.append(proName)
            }
        }
        return names
    }
    //MARK: --- 获取类的方法列表
    /// 获取类的方法列表
    func yi_get_class_copyMethodList() -> [String] {
        var outCount:UInt32
        outCount = 0
        let methods:UnsafeMutablePointer<objc_property_t>! =  class_copyMethodList(self.classForCoder, &outCount)
        let count:Int = Int(outCount);
        var names:[String] = [String]()
        for i in 0...(count-1) {
            let aMet: objc_property_t = methods[i]
            if let methodName:String = String(utf8String: property_getName(aMet)){
                names.append(methodName)
            }
        }
        return names
    }
}


