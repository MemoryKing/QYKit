/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit

//MARK: ---------- 沙盒路径 ----------
public extension String {
    /** 获取沙盒Document路径 */
    static let WDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    /**获取沙盒Cache路径 */
    static let WCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    /** 获取沙盒temp路径 */
    static let WTempPath = NSTemporaryDirectory()
}
