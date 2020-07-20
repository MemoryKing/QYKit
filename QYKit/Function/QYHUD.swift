/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation

import PKHUD

public class QYHUD: NSObject {
    
    public class func show (_ str : String? = nil,
                            _ afterDelay : TimeInterval? = 1.5,
                            _ block : ((Bool) -> Void)? = nil) {
        completionBlock = block
        afterDelayTime = afterDelay
        HUD.show(.label(str), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        
        self.hideTime()
    }
    
    public class func showSuccess (_ title : String? = nil,
                                   _ subtitle : String? = nil,
                                   _ afterDelay : TimeInterval? = 1.5,
                                   _ block : ((Bool) -> Void)? = nil) {
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
    
    public class func showError (_ title : String? = nil,
                                 _ subtitle : String? = nil,
                                 _ afterDelay : TimeInterval? = 1.5,
                                 _ block : ((Bool) -> Void)? = nil) {
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
    
    public class func showProgress (_ title : String? = nil,
                                         _ subtitle : String? = nil,
                                         _ afterDelay : TimeInterval? = 0,
                                         _ block : ((Bool) -> Void)? = nil) {
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
    
    private class func hideTime () {
        HUD.hide(afterDelay: afterDelayTime ?? 1.5, completion: completionBlock)
    }
}

public extension QYHUD {
    
    struct RuntimeKey {
        static let completionBlockKey = UnsafeRawPointer.init(bitPattern: "completionBlock".hashValue)
        static let afterDelayKey      = UnsafeRawPointer.init(bitPattern: "afterDelay".hashValue)
    }
    
    class var completionBlock : ((Bool) -> (Void))? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.completionBlockKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, RuntimeKey.completionBlockKey!) as? ((Bool) -> (Void))
        }
    }
    
    class var afterDelayTime : TimeInterval? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.afterDelayKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, RuntimeKey.afterDelayKey!) as? TimeInterval
        }
    }
}
