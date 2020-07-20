/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit

extension UIDevice {
    //////系统名
    static var system_name : String {
        return UIDevice.current.systemName
    }
    ///系统版本
    static var system_version : String {
        return UIDevice.current.systemVersion
    }
    ///uuid
    static var idForVendor : String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    //设备名
    static var deviceName : String {
        return UIDevice.current.name
    }
    ///设备语言
    static var deviceLanguage : String {
        return Bundle.main.preferredLocalizations[0]
    }
    ///是否是手机
    static var isPhone : Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    ///是否是iPad
    static var isPad : Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    ///设备型号
    static var model = UIDevice.current.model
    ///设备区域化型号
    static var localizedModel = UIDevice.current.localizedModel
}
