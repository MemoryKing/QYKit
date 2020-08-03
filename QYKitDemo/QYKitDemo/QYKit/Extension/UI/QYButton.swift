/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit

public extension UIButton {
    var yi_title: String? {
        get { return self.title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    var yi_titleFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    var yi_attributedTitle: NSAttributedString? {
        get { return self.attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }
    
    var yi_titleColor: UIColor? {
        get { return self.titleColor(for: .normal) }
        set {
            setTitleColor(newValue, for: .normal)
            setTitleColor(newValue?.withAlphaComponent(0.5), for: .disabled)
            setTitleColor(newValue, for: .selected)
            if buttonType == .custom {
                setTitleColor(newValue?.withAlphaComponent(0.5), for: .highlighted)
            }
        }
    }
    
    var yi_titleShadowColor: UIColor? {
        get { return self.titleShadowColor(for: .normal) }
        set {
            setTitleShadowColor(newValue, for: .normal)
            setTitleShadowColor(newValue?.withAlphaComponent(0.5), for: .disabled)
            setTitleShadowColor(newValue, for: .selected)
        }
    }
    
    var yi_image: UIImage? {
        get { return self.image(for: .normal) }
        set {
            setImage(newValue?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    var yi_selectedImage: UIImage? {
        get { return self.image(for: .selected) }
        set { setImage(newValue?.withRenderingMode(.alwaysOriginal), for: .selected) }
    }
    
    var yi_backgroundImage: UIImage? {
        get { return self.backgroundImage(for: .normal) }
        set {
            let image = newValue?.withRenderingMode(.alwaysOriginal)
            setBackgroundImage(image, for: .normal)
        }
    }
    
    var yi_selectedBackgroundImage: UIImage? {
        get { return self.backgroundImage(for: .selected) }
        set { setBackgroundImage(newValue?.withRenderingMode(.alwaysOriginal), for: .selected) }
    }
    
    var yi_disabledBackgroundImage: UIImage? {
        get { return self.backgroundImage(for: .disabled) }
        set { setBackgroundImage(newValue?.withRenderingMode(.alwaysOriginal), for: .disabled) }
    }
}

public enum QYButtonImagePosition: Int {
    case left       = 0x0
    case right      = 0x01
    case top        = 0x02
    case bottom     = 0x03
}
public extension UIButton {
    /// 图片文本位置
    /// - Parameters:
    ///   - type: 图片位置
    ///   - imageWidth: 图片大小
    ///   - space: 间距
    func yi_imagePosition(_ type: QYButtonImagePosition,_ imageW: CGFloat? = 0,_ imageH: CGFloat? = 0,_ space: CGFloat) {
        var image: UIImage?
        if imageW != 0 && imageH != 0 {
            image = UIImage.yi_scale(self.imageView?.image ?? UIImage(), imageW ?? 0.0,imageH ?? 0.0)
            self.setImage(image, for: .normal)
        }
        let imageWidth = self.imageView?.image?.size.width ?? 0
        let imageHeight = self.imageView?.image?.size.height ?? 0
        let titleWidth = self.titleLabel?.text?.yi_getWidth((self.titleLabel?.font)!) ?? 0
        let titleHeight = self.titleLabel?.font.pointSize ?? 0
        let insetAmount = space / 2
        let imageOffWidth = (imageWidth + titleWidth) / 2 - imageWidth / 2
        let imageOffHeight = imageHeight / 2 + insetAmount
        let titleOffWidth = imageWidth + titleWidth / 2 - (imageWidth + titleWidth) / 2
        let titleOffHeight = titleHeight / 2 + insetAmount
        switch type {
            case .left:
                self.imageEdgeInsets = .init(top: 0, left: -insetAmount,
                                             bottom: 0, right: insetAmount)
                self.titleEdgeInsets = .init(top: 0, left: insetAmount,
                                             bottom: 0, right: -insetAmount)
                self.contentHorizontalAlignment = .center
            case .right:
                self.imageEdgeInsets = .init(top: 0, left: titleWidth + insetAmount,
                                             bottom: 0, right: -(titleWidth + insetAmount))
                self.titleEdgeInsets = .init(top: 0, left: -(imageWidth + insetAmount),
                                             bottom: 0, right: imageWidth + insetAmount)
                self.contentHorizontalAlignment = .center
            case .top:
                self.imageEdgeInsets = .init(top: -imageOffHeight, left: imageOffWidth,
                                             bottom: imageOffHeight, right: -imageOffWidth)
                self.titleEdgeInsets = .init(top: titleOffHeight, left: -titleOffWidth,
                                             bottom: -titleOffHeight, right: titleOffWidth)
                self.contentVerticalAlignment = .center
            case .bottom:
                self.imageEdgeInsets = .init(top: imageOffHeight, left: imageOffWidth,
                                             bottom: -imageOffHeight, right: -imageOffWidth)
                self.titleEdgeInsets = .init(top: -titleOffHeight, left: -titleOffWidth,
                                             bottom: titleOffHeight, right: titleOffWidth)
                self.contentVerticalAlignment = .center
        }
    }
}
