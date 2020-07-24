/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation

public class QYAppInfo {
    //MARK: --- App 名称
    ///App 名称
    static var yi_displayName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    }
    //MARK: --- Bundle Identifier
    ///Bundle Identifier
    static var yi_bundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    //MARK: --- App 版本号
    ///App 版本号
    static var yi_version: String {
        return Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as! String
    }
    //MARK: --- Bulid 版本号
    //Bulid 版本号
    static var yi_buildVersion: String {
        return Bundle.main.infoDictionary? ["CFBundleVersion"] as! String
    }
}
