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
public enum QYHUDLocation {
    case top
    case center
    case bottom
}

open class QYHUD {
    ///单例
    static var shared = QYHUD()
    ///超时时间
    public var yi_afterDelayTime: TimeInterval?
    ///是否动画
    public var yi_animated: Bool = true
    ///位置
    public var yi_location = QYHUDLocation.center
    ///背景颜色
    public var yi_backgroundColor = UIColor.black
    ///文本颜色
    public var yi_textColor = UIColor.white
    ///是否遮罩层
    public var yi_isMask = true
    
    ///显示文本
    public static func yi_show(_ text: String,_ completion:(() -> ())? = nil) {
        DispatchQueue.yi_getMainAsync {
            let hud = MBProgressHUD.showAdded(to: onView, animated: qyhud.yi_animated)
            hud.label.text = text
            hud.mode = .text
            qyhud.defaultConfiguration(hud)
            hud.completionBlock = completion
            
            if let time = qyhud.yi_afterDelayTime {
                hud.minShowTime = time
            } else {
                if text.count / 6 < 1 {
                    hud.minShowTime = 1.5
                } else {
                    hud.minShowTime = TimeInterval(text.count / 6 + 3 / 4)
                }
            }
            hud.hide(animated: qyhud.yi_animated)
        }
    }
    
    //MARK: --- 菊花
    ///菊花
    public static func yi_loading(_ text: String? = nil) {
        DispatchQueue.yi_getMainAsync {
            let hud = MBProgressHUD.showAdded(to: onView, animated: qyhud.yi_animated)
            hud.label.text = text
            hud.mode = .indeterminate
            qyhud.defaultConfiguration(hud)
        }
    }
    
    //MARK: --- 默认配置
    ///默认配置
    private func defaultConfiguration(_ hud: MBProgressHUD) {
        ///多行
        hud.label.numberOfLines = 0
        hud.bezelView.style = .solidColor
        hud.contentColor = yi_textColor
        hud.bezelView.backgroundColor = yi_backgroundColor
        
        ///位置
        switch yi_location {
            case .top:
                hud.offset = .init(x: 0, y: -MBProgressMaxOffset)
            case .center:
                hud.offset = .init(x: 0, y: 0)
            case .bottom:
                hud.offset = .init(x: 0, y: MBProgressMaxOffset)
        }
        hud.removeFromSuperViewOnHide = true
    }
    
    ///当前视图
    private static var onView: UIView {
        if let view = NSObject().yi_getTopViewController()?.view {
            return view
        }
        return UIApplication.shared.keyWindow?.rootViewController?.view ?? UIView()
    }
    
}
