/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit

//MARK:   -------   功能 ----------
public extension UIView {
    ///阴影
    func shadows (color : UIColor, size : CGSize, radius : CGFloat, opacity : Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = size
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    //切圆角
    func roundeConrners (rectCon : UIRectCorner, cornerRadii : CGSize) {
        let rounded = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: rectCon, cornerRadii: cornerRadii)
        let shape = CAShapeLayer.init()
        shape.path = rounded.cgPath
        layer.mask = shape
    }
}

//MARK:   -------   效果 ----------
public extension UIView {
    
    func groundGlassEffect (frame : CGRect , style : UIBlurEffect.Style) {
        //初始化一个模糊效果对象（可以制作毛玻璃效果）
        let blur = UIBlurEffect(style: style)
        //初始化一个基于模糊效果的视觉效果视图
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = frame
        self.addSubview(blurView)
    }
    
    ///画虚线
    func drawDashLine(lineLength : Int ,lineSpacing : Int,lineColor : UIColor){
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
    
    
}

