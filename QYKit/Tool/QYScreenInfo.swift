/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import Foundation
import UIKit

///比例大小
public func QYRatio(_ num: CGFloat) -> CGFloat {
    return num * QYProportion
}
///比例字体大小
public func QYFont(_ num: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: num * QYProportion)
}
///比例字体大小加粗
public func QYBoldFont(_ num: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: num * QYProportion)
}
///屏幕宽
public var QYWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}
///屏幕高
public var QYHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}
///屏幕比例
public var QYProportion: CGFloat {
    return UIScreen.main.bounds.size.width / 375.0
}
///导航高度
public let QYNavHeight: CGFloat = 44.0
///tabbar栏高度
public let QYTabBarHeight: CGFloat = 49.0
///底部安全区域
public var QYBottomHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.size.height > 20.1 ? 34.0: 0.0
}
///状态条占的高度
public var QYStatusHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.height
}
///导航栏高度 + 状态栏高度
public var QYStatusAndNavHeight: CGFloat {
    return QYStatusHeight + QYNavHeight
}
///tabbar高度 + iphoneX多出来的高度
public var QYBottomAndTabBarHeight: CGFloat {
    return QYBottomHeight + QYTabBarHeight
}

open class QYScreenInfo: NSObject {
    
}

