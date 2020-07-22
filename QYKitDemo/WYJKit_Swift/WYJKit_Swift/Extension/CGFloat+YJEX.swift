/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit


public let SCREEN_WIDTH = UIScreen.main.bounds.size.width

public extension CGFloat {
    init(_ str: String) {
        self.init(Double(str) ?? 0)
    }
    
    //MARK: ---------- 屏幕宽高 ----------
    /** 屏幕宽 */
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    /** 屏幕高 */
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    /** 比例宽 */
    static func WRatioSize (_ x : CGFloat) -> (CGFloat) {
        return CGFloat(x * UIScreen.main.bounds.size.width / 375.0)
    }
    /** 导航栏高度 */
    static let WNavBarHeight : CGFloat = 44.0
    /** tabbar栏高度 */
    static let WTabbarHeight : CGFloat = 49.0
    /** 底部安全区域 */
    static let WBottomSafeHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height > 20.1 ? 34.0 : 0.0
    /** 状态条的高度 */
    static let WStatusForHeigh : CGFloat = UIApplication.shared.statusBarFrame.size.height
    /** 导航栏高度 + 状态栏高度 */
    static let WStatusAndNavForHeight : CGFloat = WNavBarHeight + WStatusForHeigh
    /** tabbar高度 + iphoneX多出来的高度 */
    static let WBottomSafeAndTabbarForHeight : CGFloat = WTabbarHeight + WBottomSafeHeight
    
}
