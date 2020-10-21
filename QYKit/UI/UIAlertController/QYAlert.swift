/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation
import UIKit

///系统提示窗
open class QYAlert: UIView {
    //MARK: --- 系统提示框
    /// 系统提示框
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - highlighted: 高亮
    ///   - handler: 设置action
    ///   - titleArr: 选择数组
    ///   - type: 类型
    public class func yi_show(title: String? = "",
                       message: String,
                       titleArr: [String],
                       highlighted: Int? = 1,
                       handler: ((UIAlertController,UIAlertAction,NSInteger) -> Void)?,
                       type: UIAlertController.Style = .alert,
                       complete: @escaping ((NSInteger,String)->(Void))) {
        var mes = message
        if let tit = title, tit.count != 0 {
            mes = "\n" + mes
        }
        let alert = UIAlertController(title: title, message: mes, preferredStyle: type)
        for (index,item) in titleArr.enumerated() {
            let action = UIAlertAction.init(title: item, style: .default, handler: { (action) in
                complete(index,item)
                if let high = highlighted, high == index {
                    alert.preferredAction = action
                }
            })
            handler?(alert,action,index)
            alert.addAction(action)
        }
        
        if type == .actionSheet {
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //MARK: --- 系统提示框带输入框
    /// 系统提示框带输入框
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - titleArr: 选择数组
    ///   - highlighted: 高亮
    ///   - textFields: 输入框数组
    ///   - actionHandler: 设置Alert
    ///   - tfHandler: 设置输入框
    ///   - type: 类型
    public class func yi_show(title: String? = "",message: String,
                       titleArr: [String],
                       highlighted: Int? = 1,
                       textFields: [String],
                       actionHandler: ((UIAlertController,UIAlertAction,NSInteger) -> Void)?,
                       tfHandler: ((UITextField,NSInteger) -> Void)?,
                       type: UIAlertController.Style = .alert,
                       complete: @escaping ((NSInteger,String)->(Void))) {
        var mes = message
        if let tit = title, tit.count != 0 {
            mes = "\n" + mes
        }
        let alert = UIAlertController(title: title, message: mes, preferredStyle: type)
        for (index,item) in titleArr.enumerated() {
            let action = UIAlertAction.init(title: item, style: .default, handler: { (action) in
                if let high = highlighted, high == index {
                    alert.preferredAction = action
                }
                complete(index,item)
            })
            actionHandler?(alert,action,index)
            alert.addAction(action)
        }
        for (index,item) in textFields.enumerated() {
            alert.addTextField { (tf) in
                tf.placeholder = item
                tfHandler?(tf,index)
            }
        }
        
        if type == .actionSheet {
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        }
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

//MARK: --- UIAlertController 属性
public extension UIAlertController {
    //MARK: --- 标题文本颜色
    ///标题文本颜色
    var yi_titleColor: UIColor? {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.titleColorKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            let titleAtt = NSMutableAttributedString.init(string: self.title ?? "")
            titleAtt.addAttribute(.foregroundColor, value: newValue ?? UIColor.black, range: .init(location: 0, length: self.title?.count ?? 0))
            titleAtt.addAttribute(.font, value: self.yi_titleFont ?? QYFont(17), range: .init(location: 0, length: titleAtt.length))
            self.setValue(titleAtt, forKey: "attributedTitle")
        }
        get {
            let color = objc_getAssociatedObject(self, QYRuntimeKey.titleColorKey!) as? UIColor
            return color
        }
    }
    
    //MARK: --- 标题文本字体
    ///标题文本字体
    var yi_titleFont: UIFont? {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.titleFontKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            let titleAtt = NSMutableAttributedString.init(string: self.title ?? "")
            titleAtt.addAttribute(.foregroundColor, value: self.yi_titleColor ?? UIColor.black, range: .init(location: 0, length: self.title?.count ?? 0))
            titleAtt.addAttribute(.font, value: newValue ?? QYFont(17), range: .init(location: 0, length: titleAtt.length))
            self.setValue(titleAtt, forKey: "attributedTitle")
        }
        get {
            let font = objc_getAssociatedObject(self, QYRuntimeKey.titleFontKey!) as? UIFont
            return font
        }
    }
    
    //MARK: --- 标题富文本
    ///标题富文本
    var yi_attributedTitle: NSAttributedString? {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.attributedTitleKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.setValue(newValue, forKey: "attributedTitle")
        }
        get {
            let att = objc_getAssociatedObject(self, QYRuntimeKey.attributedTitleKey!) as? NSAttributedString
            return att
        }
    }
    
    //MARK: --- 内容颜色
    ///内容颜色
    var yi_messageColor: UIColor? {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.messageColorKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            let titleAtt = NSMutableAttributedString.init(string: self.message ?? "")
            titleAtt.addAttribute(.foregroundColor, value: newValue ?? UIColor.black, range: .init(location: 0, length: self.message?.count ?? 0))
            titleAtt.addAttribute(.font, value: self.yi_titleFont ?? QYFont(17), range: .init(location: 0, length: titleAtt.length))
            self.setValue(titleAtt, forKey: "attributedMessage")
        }
        get {
            let color = objc_getAssociatedObject(self, QYRuntimeKey.messageColorKey!) as? UIColor
            return color
        }
    }
    
    //MARK: --- 内容字体
    ///内容字体
    var yi_messageFont: UIFont? {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.messageFontKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            let titleAtt = NSMutableAttributedString.init(string: self.message ?? "")
            titleAtt.addAttribute(.foregroundColor, value: self.yi_messageColor ?? UIColor.black, range: .init(location: 0, length: self.message?.count ?? 0))
            titleAtt.addAttribute(.font, value: newValue ?? QYFont(15), range: .init(location: 0, length: titleAtt.length))
            self.setValue(titleAtt, forKey: "attributedMessage")
        }
        get {
            let font = objc_getAssociatedObject(self, QYRuntimeKey.messageFontKey!) as? UIFont
            return font
        }
    }
    
    //MARK: --- 内容富文本
    ///内容富文本
    var yi_attributedMessage: NSAttributedString? {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.attributedMessageKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.setValue(newValue, forKey: "attributedMessage")
        }
        get {
            let att = objc_getAssociatedObject(self, QYRuntimeKey.attributedMessageKey!) as? NSAttributedString
            return att
        }
    }
    
    private struct QYRuntimeKey {
        static let titleColorKey = UnsafeRawPointer.init(bitPattern: "titleColorKey".hashValue)
        static let titleFontKey = UnsafeRawPointer.init(bitPattern: "titleFontKey".hashValue)
        static let attributedTitleKey = UnsafeRawPointer.init(bitPattern: "attributedTitle".hashValue)
        static let messageColorKey = UnsafeRawPointer.init(bitPattern: "messageColorKey".hashValue)
        static let messageFontKey = UnsafeRawPointer.init(bitPattern: "messageFontKey".hashValue)
        static let attributedMessageKey = UnsafeRawPointer.init(bitPattern: "attributedmessage".hashValue)
    }
}

//MARK: --- UIAlertAction  属性
public extension UIAlertAction {
    //MARK: --- 文本颜色
    ///文本颜色
    var yi_titleColor: UIColor? {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.titleColorKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.setValue(newValue, forKey: "titleTextColor")
        }
        get {
            let color = objc_getAssociatedObject(self, QYRuntimeKey.titleColorKey!) as? UIColor
            return color
        }
    }
    
    //MARK: --- 图片
    ///图片
    var yi_image: UIImage? {
        set {
            objc_setAssociatedObject(self, QYRuntimeKey.imageKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.setValue(newValue?.withRenderingMode(.alwaysOriginal), forKey: "image")
        }
        get {
            let img = objc_getAssociatedObject(self, QYRuntimeKey.imageKey!) as? UIImage
            return img
        }
    }
    
    private struct QYRuntimeKey {
        static let titleColorKey = UnsafeRawPointer.init(bitPattern: "titleColorKey".hashValue)
        static let imageKey = UnsafeRawPointer.init(bitPattern: "imageKey".hashValue)
    }
}
