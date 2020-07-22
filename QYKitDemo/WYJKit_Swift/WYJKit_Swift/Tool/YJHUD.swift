/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation

import PKHUD

public class YJHUD: NSObject {
    
    public class func show (_ str : String?) -> () {
        YJHUD.show(str, afterDelay: nil, nil)
    }
    
    public class func show (_ str : String?,
                     _ block : ((Bool) -> Void)? = nil) -> () {
        YJHUD.show(str, afterDelay: nil, block)
    }
    
    public class func show (_ str : String?,
                     afterDelay : TimeInterval?,
                     _ block : ((Bool) -> Void)? = nil) -> () {
        completionBlock = block
        afterDelayTime = afterDelay
        HUD.show(.label(str), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        self.hideTime()
    }
    
    
    public class func showSuccess (_ str : String?) -> () {
        YJHUD.showSuccess(title: nil, subtitle: str, afterDelay: nil, nil)
    }
    
    public class func showSuccess (title : String? ,
                            subtitle : String?) -> () {
        YJHUD.showSuccess(title: title, subtitle: subtitle, afterDelay: nil, nil)
    }
    
    public class func showSuccess (title : String? ,
                            subtitle : String?,
                            afterDelay : TimeInterval?) -> () {
        YJHUD.showSuccess(title: title, subtitle: subtitle, afterDelay: afterDelay, nil)
    }
    
    public class func showSuccess (_ title : String? ,
                            _ block : ((Bool) -> Void)? = nil) -> () {
        YJHUD.showSuccess(title: nil, subtitle: title, afterDelay: nil, block)
    }
    
    public class func showSuccess (title : String? ,
                            subtitle : String?,
                            afterDelay : TimeInterval?,
                            _ block : ((Bool) -> Void)? = nil) -> () {
        completionBlock = block
        afterDelayTime = afterDelay
        HUD.show(.labeledSuccess(title: title, subtitle: subtitle), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        self.hideTime()
    }
    
    
    public class func showError (_ str : String?) -> () {
        YJHUD.showError(title: nil, subtitle: str, afterDelay: nil, nil)
    }
    
    public class func showError (title : String? ,
                            subtitle : String?) -> () {
        YJHUD.showError(title: title, subtitle: subtitle, afterDelay: nil, nil)
    }
    
    public class func showError (title : String? ,
                            subtitle : String?,
                            afterDelay : TimeInterval?) -> () {
        YJHUD.showError(title: title, subtitle: subtitle, afterDelay: afterDelay, nil)
    }
    
    public class func showError (_ title : String? ,
                            _ block : ((Bool) -> Void)? = nil) -> () {
        YJHUD.showError(title: nil, subtitle: title, afterDelay: nil, block)
    }
    
    public class func showError (title : String? ,
                            subtitle : String?,
                            afterDelay : TimeInterval?,
                            _ block : ((Bool) -> Void)? = nil) -> () {
        completionBlock = block
        afterDelayTime = afterDelay
        HUD.show(.labeledError(title: title, subtitle: subtitle), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        self.hideTime()
    }
    
    
    public class func showProgress (_ str : String?) -> () {
        YJHUD.showProgress(title: nil, subtitle: str, afterDelay: nil, nil)
    }
    
    public class func showProgress (title : String? ,
                          subtitle : String?) -> () {
        YJHUD.showProgress(title: title, subtitle: subtitle, afterDelay: nil, nil)
    }
    
    public class func showProgress (title : String? ,
                          subtitle : String?,
                          afterDelay : TimeInterval?) -> () {
        YJHUD.showProgress(title: title, subtitle: subtitle, afterDelay: afterDelay, nil)
    }
    
    public class func showProgress (_ title : String? ,
                          _ block : ((Bool) -> Void)? = nil) -> () {
        YJHUD.showProgress(title: nil, subtitle: title, afterDelay: nil, block)
    }
    
    public class func showProgress (title : String? ,
                          subtitle : String?,
                          afterDelay : TimeInterval?,
                          _ block : ((Bool) -> Void)? = nil) -> () {
        completionBlock = block
        afterDelayTime = afterDelay
        HUD.show(.labeledProgress(title: title, subtitle: subtitle), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
        self.hideTime()
    }
    
    private class func hideTime () {
        HUD.hide(afterDelay: afterDelayTime ?? 1.5, completion: completionBlock)
    }
}

public extension YJHUD {
    
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
