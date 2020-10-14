/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit
import Foundation
import QuartzCore
//MARK: --- 框线
public extension UIView {
    
    enum ViewSide {
        case top
        case right
        case bottom
        case left
    }
    //MARK: --- 单边边框线
    func yi_addBorder(side: ViewSide, thickness: CGFloat, color: UIColor, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        self.layoutIfNeeded()
        switch side {
        case .top:
            // Add leftOffset to our X to get start X position.
            // Add topOffset to Y to get start Y position
            // Subtract left offset from width to negate shifting from leftOffset.
            // Subtract rightoffset from width to set end X and Width.
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                             y: 0 + topOffset,
                                             width: self.bounds.size.width - leftOffset - rightOffset,
                                             height: thickness), color: color)
            self.layer.addSublayer(border)
        case .right:
            // Subtract the rightOffset from our width + thickness to get our final x position.
            // Add topOffset to our y to get our start y position.
            // Subtract topOffset from our height, so our border doesn't extend past teh view.
            // Subtract bottomOffset from the height to get our end.
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: self.frame.size.width-thickness-rightOffset,
                                             y: 0 + topOffset, width: thickness,
                                             height: self.bounds.size.height - topOffset - bottomOffset), color: color)
            self.layer.addSublayer(border)
        case .bottom:
            // Subtract the bottomOffset from the height and the thickness to get our final y position.
            // Add a left offset to our x to get our x position.
            // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                             y: self.bounds.size.height-thickness-bottomOffset,
                                             width: self.bounds.size.width - leftOffset - rightOffset, height: thickness), color: color)
            self.layer.addSublayer(border)
        case .left:
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                             y: 0 + topOffset,
                                             width: thickness,
                                             height: self.bounds.size.height - topOffset - bottomOffset), color: color)
            self.layer.addSublayer(border)
        }
    }
    fileprivate func _getOneSidedBorder(frame: CGRect, color: UIColor) -> CALayer {
        let border:CALayer = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        return border
    }
    fileprivate func _getViewBackedOneSidedBorder(frame: CGRect, color: UIColor) -> UIView {
        let border:UIView = UIView.init(frame: frame)
        border.backgroundColor = color
        return border
    }
}

//MARK: --- 渐变色
public extension UIView {
    /// 渐变色方向
    enum GradientDirection {
        ///垂直
        case vertical
        ///水平
        case level
        ///左上到右下
        case leftTop
        ///左下到右上
        case leftBottom
    }
    
    /// 渐变色
    /// - Parameters:
    ///   - direction: 方向
    ///   - locations: 位置
    ///   - colors: 颜色组
    func yi_setGradientLayer (direction: GradientDirection,locations: Array<NSNumber> = [0.0,1.0] ,colors: [UIColor]) {
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = self.bounds
        var cgColors = [CGColor]()
        colors.forEach { (colo) in
            cgColors.append(colo.cgColor)
        }
        gradientLayer.colors = cgColors
        gradientLayer.locations = locations
        switch direction {
        case .vertical:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1.0)
            break
        case .level:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0)
            break
        case .leftTop:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 1.0)
            break
        case .leftBottom:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 1.0)
            gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0.0)
            break
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
//MARK: --- 跳转
public extension UIView {
    
    func yi_push(_ vc: UIViewController, animated: Bool = true) {
        let currentC = yi_currentController()
        if yi_currentController() == nil {
            NSLog("current controller is nil")
        } else {
            if currentC!.isKind(of: UINavigationController.self) {
                let nav: UINavigationController = currentC as! UINavigationController
                if nav.viewControllers.count > 0 {
                    vc.hidesBottomBarWhenPushed = true
                }
                nav.pushViewController(vc, animated: animated)
            } else {
                if currentC?.navigationController != nil {
                    let nav: UINavigationController = currentC!.navigationController!
                    if nav.viewControllers.count > 0 {
                        vc.hidesBottomBarWhenPushed = true
                    }
                    currentC!.navigationController!.pushViewController(vc, animated: animated)
                }
            }
        }
    }
    
    func yi_pop(_ animated: Bool = true) {
        let currentC = yi_currentController()
        if yi_currentController() == nil {
            NSLog("current controller is nil")
        } else {
            if currentC!.isKind(of: UINavigationController.self) {
                ((currentC as? UINavigationController))?.popViewController(animated: animated)
            } else {
                currentC!.navigationController?.popViewController(animated: animated)
            }
        }
    }
    
    func yi_popToRootViewController(_ animated: Bool = true) {
        let currentC = yi_currentController()
        if yi_currentController() == nil {
            NSLog("current controller is nil")
        } else {
            if currentC!.isKind(of: UINavigationController.self) {
                (currentC as! UINavigationController).popToRootViewController(animated: true)
            } else {
                currentC!.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    func yi_present(_ vc: UIViewController, animated: Bool = true) {
        if yi_currentController() == nil {
            NSLog("current controller is nil")
        } else {
            yi_currentController()?.present(vc, animated: animated, completion: nil)
        }
    }
    func yi_dismiss(_ animated: Bool = true) {
        if yi_currentController() == nil {
            NSLog("current controller is nil")
        } else {
            yi_currentController()? .dismiss(animated: animated, completion: nil)
        }
    }
    ///获取父控制器
    func yi_currentController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UINavigationController.self) {
                    let tab = responder as! UINavigationController
                    return tab.visibleViewController
                } else if responder.isKind(of: UITabBarController.self) {
                    let tab = responder as! UITabBarController
                    return tab.selectedViewController
                } else if responder.isKind(of: UIViewController.self) {
                    let vc = responder as! UIViewController
                    return vc
                }
            }
        }
        return nil
    }
}
//MARK: --- frame
public extension UIView {
    func yi_addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.width, height: self.height)
        }
    }
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.width, height: self.height)
        }
    }
    var width: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.height)
        }
    }
    var height: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: value)
        }
    }
    var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }
    var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }
    var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
}

//MARK: --- layer
public extension UIView {
    //MARK: --- 连框
    ///连框
    var yi_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    //MARK: --- 圆角
    ///圆角
    var yi_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    ///圆角
    func yi_cornerRadius(_ corners: UIRectCorner,_ radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    //MARK: --- 阴影
    ///阴影
    func yi_addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float,_ cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    //MARK: ------- 边框
    ///边框
    func yi_addBorder(width: CGFloat, _ color: UIColor = .black) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    ///边框-上
    func yi_addBorderTop(_ size: CGFloat,_ padding: CGFloat = 0,_ color: UIColor = .black) {
        _addBorderUtility(x: padding, y: 0, width: frame.width - padding * 2, height: size, color: color)
    }
    
    ///边框-下
    func yi_addBorderBottom(_ size: CGFloat,_ padding: CGFloat = 0,_ color: UIColor = .black) {
        _addBorderUtility(x: padding, y: frame.height - size, width: frame.width - padding * 2, height: size, color: color)
    }
    
    ///边框-左
    func yi_addBorderLeft(_ size: CGFloat,_ padding: CGFloat = 0,_ color: UIColor = .black) {
        _addBorderUtility(x: 0, y: padding, width: size, height: frame.height - padding * 2, color: color)
    }
    
    ///边框-右
    func yi_addBorderRight(_ size: CGFloat,_ padding: CGFloat = 0,_ color: UIColor = .black) {
        _addBorderUtility(x: frame.width - size, y: padding, width: size, height: frame.height - padding * 2, color: color)
    }
    
    private func _addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    
    //MARK: --- 绘画
    ///画圆
    func yi_drawCircle(fillColor: UIColor,_ strokeColor: UIColor = .black, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    
    ///画中空圆
    func yi_drawStroke(width: CGFloat,_ color: UIColor = .black) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
    
    ///画虚线
    func yi_drawDashLine(lineLength: Int ,lineSpacing: Int,lineColor: UIColor){
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = bounds
        //        只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        //        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        
        shapeLayer.lineWidth = bounds.size.height
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength),NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: bounds.size.width, y: 0))
        
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    ///移除layer
    func yi_removeLayer() {
        self.layer.mask = nil
        self.layer.borderWidth = 0
    }
}

//MARK: --- 转换
public extension UIView {
    ///转换成图片
    func yi_toImage(_ size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage.init()
    }
    ///转换成图片
    func yi_toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
        
}

//MARK: --- 手势
public extension UIView {
    ///单击
    func yi_addTapGesture(_ tapNumber: Int = 1,
                          target: AnyObject,
                          action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    ///单击
    func yi_addTapGesture(_ tapNumber: Int = 1,
                          action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    ///滑动
    func yi_addSwipeGesture(_ direction: UISwipeGestureRecognizer.Direction,
                            _ numberOfTouches: Int = 1,
                            target: AnyObject,
                            action: Selector) {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    ///滑动
    func yi_addSwipeGesture(_ direction: UISwipeGestureRecognizer.Direction,
                            _ numberOfTouches: Int = 1,
                            action: ((UISwipeGestureRecognizer) -> Void)?) {
        let swipe = BlockSwipe(direction: direction, fingerCount: numberOfTouches, action: action)
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    ///拖动
    func yi_addPanGesture(target: AnyObject, action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    ///拖动
    func yi_addPanGesture(action: ((UIPanGestureRecognizer) -> Void)?) {
        let pan = BlockPan(action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    ///长按
    func yi_addLongPressGesture(target: AnyObject, action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
    ///长按
    func yi_addLongPressGesture(action: ((UILongPressGestureRecognizer) -> Void)?) {
        let longPress = BlockLongPress(action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
}



