/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation

class QYAppInfo {
    ///版本号
    static var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    ///App 名称
    static var appDisplayName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    }
    ///Bundle Identifier
    static var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    ///App 版本号
    static var appVersion: String {
        return Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as! String
    }
    //Bulid 版本号
    static var buildVersion: String {
        return Bundle.main.infoDictionary? ["CFBundleVersion"] as! String
    }
}
