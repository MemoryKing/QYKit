/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit

public class YJTOOL {
    
    /** 开发的时候打印，但是发布的时候不打印 */
    class func WNSLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
        #if DEBUG
        //获取当前时间
        let now = Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        // 要把路径最后的字符串截取出来
        let lastName = ((fileName as NSString).pathComponents.last!)
        print("\(dformatter.string(from: now)) [\(lastName)][第\(lineNumber)行] \t \(message)")
        #endif
    }
}

//MARK:   -------  跳转App Store  ----------
public extension YJTOOL {
    /// go app store
    class func gotoAppStore(_ string : String) {
        let appID = string
        let urlString = "\("http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=")\(appID)\("&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8")"
        let url = URL(string: urlString)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
        
    }
    
    /// share friend
    class func SharedFriend (name:String, image:UIImage, appid:String) {
        let url = NSURL.init(string: "itms-apps://itunes.apple.com/app/id\(appid)")
        let imgs = [name,image,url!] as [Any]
        let activityC = UIActivityViewController.init(activityItems: imgs, applicationActivities: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(activityC, animated: true, completion: nil)
    }
}

//MARK:   -------   机型判断 ----------
public extension YJTOOL {
    static let IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
    static let IPAD = (UIDevice.current.userInterfaceIdiom == .pad)
    static let IPHONE5 = (IPHONE && UIScreen.main.bounds.size.height == 568.0)
    static let IPHONE6 = (IPHONE && UIScreen.main.bounds.size.height == 667.0)
    static let IPHONEPLUS = (IPHONE && UIScreen.main.bounds.size.height == 736.0)
    static let IPHONEX = (IPHONE && UIScreen.main.bounds.size.height > 780.0)
}

//MARK:   -------   系统信息 ----------
public extension YJTOOL {
    ///app Version
    class func getAppVersion() ->(String) {
        let infoDictionary = Bundle.main.infoDictionary
        if let infoDictionary = infoDictionary {
            let appVersion = infoDictionary["CFBundleShortVersionString"]
            return appVersion as? String ?? ""
        }
        return ""
    }
    
    /// build Version
    class func getAppBuildVersion() ->(String) {
        let infoDictionary = Bundle.main.infoDictionary
        if let infoDictionary = infoDictionary {
            let appBuild = infoDictionary["CFBundleVersion"]
            return appBuild as? String ?? ""
        }
        return ""
    }
    
    /// Display Name
    class func getAppDisplayName() ->(String) {
        let infoDictionary = Bundle.main.infoDictionary
        if let infoDictionary = infoDictionary {
            let appBuild = infoDictionary["CFBundleDisplayName"]
            return appBuild as? String ?? ""
        }
        return ""
    }
    
    /// Bundle ID
    class func getAppBundleID() ->(String) {
        let infoDictionary = Bundle.main.infoDictionary
        if let infoDictionary = infoDictionary {
            let appBuild = infoDictionary["CFBundleIdentifier"]
            return appBuild as? String ?? ""
        }
        return ""
    }
}
