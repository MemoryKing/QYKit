/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 *******************************************************************************/


import Foundation
import MBProgressHUD

fileprivate let qyhud = QYHUD.shared

///位置
public enum QYHUDLocationStatus {
    case top
    case center
    case bottom
}

open class QYHUD: NSObject {
    ///单例
    static var shared = QYHUD()
    ///超时时间
    public var afterDelayTime: TimeInterval = 2
    ///是否动画
    public var animated: Bool = true
    ///位置
    public var locationStatus = QYHUDLocationStatus.center
    ///背景颜色
    public var backgroundColor = UIColor.black
    ///文本颜色
    public var textColor = UIColor.white
    ///是否遮罩层
    public var isMask = true
    
    ///显示文本
    public class func show(_ text: String,_ completion:(() -> ())? = nil) {
        DispatchQueue.yi_getMainAsync {
            let hud = MBProgressHUD.showAdded(to: onView, animated: qyhud.animated)
            hud.label.text = text
            hud.mode = .text
            qyhud.defaultConfiguration(hud)
            hud.hide(animated: qyhud.animated, afterDelay: qyhud.afterDelayTime)
            hud.completionBlock = completion
        }
    }
    ///加载
    public class func showProgress(_ text: String? = nil) {
        DispatchQueue.yi_getMainAsync {
            let hud = MBProgressHUD.showAdded(to: onView, animated: qyhud.animated)
            hud.label.text = text
            hud.mode = .indeterminate
            qyhud.defaultConfiguration(hud)
        }
    }
    
    private func defaultConfiguration(_ hud: MBProgressHUD) {
        ///多行
        hud.label.numberOfLines = 0
        hud.bezelView.style = .solidColor
        hud.contentColor = textColor
        hud.bezelView.backgroundColor = backgroundColor
        
        ///位置
        switch locationStatus {
            case .top:
                hud.offset = .init(x: 0, y: -MBProgressMaxOffset)
            case .center:
                hud.offset = .init(x: 0, y: 0)
            case .bottom:
                hud.offset = .init(x: 0, y: MBProgressMaxOffset)
        }
        hud.removeFromSuperViewOnHide = true
        hud.show(animated: qyhud.animated)
    }
    
    ///当前视图
    private static var onView: UIView {
        if let view = NSObject().yi_getTopViewController()?.view {
            return view
        }
        return UIApplication.shared.keyWindow?.rootViewController?.view ?? UIView()
    }
    
}
//
//public class func show (_ str: String?,
//                        _ afterDelay: TimeInterval? = 1.5,
//                        _ block: ((Bool) -> Void)? = nil) {
//    completionBlock = block
//    afterDelayTime = afterDelay
//    HUD.show(.label(str), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
//
//    self.hideTime()
//
//}
//
//public class func showSuccess (_ title: String? = nil,
//                               _ subtitle: String? = nil,
//                               _ afterDelay: TimeInterval? = 1.5,
//                               _ block: ((Bool) -> Void)? = nil) {
//    completionBlock = block
//    afterDelayTime = afterDelay
//
//    var tit = title
//    var sub = subtitle
//    if title != nil && subtitle == nil {
//        sub = title
//        tit = nil
//    }
//    HUD.show(.labeledSuccess(title: tit, subtitle: sub), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
//    self.hideTime()
//}
//
//public class func showError (_ title: String? = nil,
//                             _ subtitle: String? = nil,
//                             _ afterDelay: TimeInterval? = 1.5,
//                             _ block: ((Bool) -> Void)? = nil) {
//    completionBlock = block
//    afterDelayTime = afterDelay
//    var tit = title
//    var sub = subtitle
//    if title != nil && subtitle == nil {
//        sub = title
//        tit = nil
//    }
//    HUD.show(.labeledError(title: tit, subtitle: sub), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
//    self.hideTime()
//}
//
//public class func showProgress (_ title: String? = nil,
//                                     _ subtitle: String? = nil,
//                                     _ afterDelay: TimeInterval? = 0,
//                                     _ block: ((Bool) -> Void)? = nil) {
//    completionBlock = block
//    afterDelayTime = afterDelay
//    var tit = title
//    var sub = subtitle
//    if title != nil && subtitle == nil {
//        sub = title
//        tit = nil
//    }
//    HUD.show(.labeledProgress(title: tit, subtitle: sub), onView: UIApplication.shared.keyWindow?.rootViewController?.view)
//    if afterDelayTime! > 0.0 {
//        self.hideTime()
//    }
//}
//
//private class func hideTime() {
//    HUD.hide(afterDelay: afterDelayTime ?? 1.5, completion: completionBlock)
//}
//public class func hideHud() {
//    HUD.hide()
//}
