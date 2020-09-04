/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation

import PKHUD

open class QYHUD: NSObject {
    static var completionBlock: ((Bool) -> (Void))?
    static var afterDelayTime: TimeInterval?
    public class func show (_ str: String?,
                            _ afterDelay: TimeInterval? = 1.5,
                            _ block: ((Bool) -> Void)? = nil) {
        completionBlock = block
        afterDelayTime = afterDelay
        HUD.show(.label(str), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        
        self.hideTime()
    }
    
    public class func showSuccess (_ title: String? = nil,
                                   _ subtitle: String? = nil,
                                   _ afterDelay: TimeInterval? = 1.5,
                                   _ block: ((Bool) -> Void)? = nil) {
        completionBlock = block
        afterDelayTime = afterDelay
        
        var tit = title
        var sub = subtitle
        if title != nil && subtitle == nil {
            sub = title
            tit = nil
        }
        HUD.show(.labeledSuccess(title: tit, subtitle: sub), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        self.hideTime()
    }
    
    public class func showError (_ title: String? = nil,
                                 _ subtitle: String? = nil,
                                 _ afterDelay: TimeInterval? = 1.5,
                                 _ block: ((Bool) -> Void)? = nil) {
        completionBlock = block
        afterDelayTime = afterDelay
        var tit = title
        var sub = subtitle
        if title != nil && subtitle == nil {
            sub = title
            tit = nil
        }
        HUD.show(.labeledError(title: tit, subtitle: sub), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        self.hideTime()
    }
    
    public class func showProgress (_ title: String? = nil,
                                         _ subtitle: String? = nil,
                                         _ afterDelay: TimeInterval? = 0,
                                         _ block: ((Bool) -> Void)? = nil) {
        completionBlock = block
        afterDelayTime = afterDelay
        var tit = title
        var sub = subtitle
        if title != nil && subtitle == nil {
            sub = title
            tit = nil
        }
        HUD.show(.labeledProgress(title: tit, subtitle: sub), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        if afterDelayTime! > 0.0 {
            self.hideTime()
        }
    }
    
    private class func hideTime() {
        HUD.hide(afterDelay: afterDelayTime ?? 1.5, completion: completionBlock)
    }
    public class func hideHud() {
        HUD.hide()
    }
}

extension QYHUD {
}
