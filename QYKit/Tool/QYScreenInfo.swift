/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import Foundation
import UIKit

public func QYRatio(_ num: CGFloat) -> CGFloat {
    return QYScreenInfo.ratio(num)
}
public func QYFont(_ num: CGFloat) -> UIFont {
    return QYScreenInfo.font(num)
}

open class QYScreenInfo: NSObject {
    ///屏幕宽
    public static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    ///屏幕高
    public static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    ///屏幕比例
    public static var proportion: CGFloat {
        return UIScreen.main.bounds.size.width / 375.0
    }
    ///导航高度
    public static let navHeight: CGFloat = 44.0
    ///tabbar栏高度
    public static let tabBarHeight: CGFloat = 49.0
    ///底部安全区域
    public static var bottomHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height > 20.1 ? 34.0: 0.0
    }
    ///状态条占的高度
    public static var statusHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    ///导航栏高度 + 状态栏高度
    public static var statusAndNavHeight: CGFloat {
        return statusHeight + navHeight
    }
    ///tabbar高度 + iphoneX多出来的高度
    public static var bottomAndTabBarHeight: CGFloat {
        return bottomHeight + tabBarHeight
    }
    ///比例字体大小
    public class func font (_ font:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: font * proportion)
    }
    ///比例大小
    public class func ratio (_ num:CGFloat) -> CGFloat {
        return num * proportion
    }
}

