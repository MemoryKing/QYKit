/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit

public enum ImageGradientDirection {
    case horizontal
    case vertical
    case upperLeftDiagonal
    case downLeftDiagonal
}

public extension UIImage {
    
    convenience init(size : CGSize,colors : [UIColor], direction : ImageGradientDirection) {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = colors.map {(color: UIColor) -> AnyObject? in return color.cgColor as AnyObject? } as NSArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        
        // 第二个参数是起始位置，第三个参数是终止位置
        
        switch direction {
        case .horizontal:
            context!.drawLinearGradient(gradient!,
                                        start: CGPoint(x: 0, y: 0),
                                        end: CGPoint(x: size.width, y: 0),
                                        options: CGGradientDrawingOptions(rawValue: 0))
        case .vertical:
            context!.drawLinearGradient(gradient!,
                                        start: CGPoint(x: 0, y: 0),
                                        end: CGPoint(x: 0, y: size.height),
                                        options: CGGradientDrawingOptions(rawValue: 0))
        case .upperLeftDiagonal:
            context!.drawLinearGradient(gradient!,
                                        start: CGPoint(x: 0, y: 0),
                                        end: CGPoint(x: size.width, y: size.height),
                                        options: CGGradientDrawingOptions(rawValue: 0))
        case .downLeftDiagonal:
            context!.drawLinearGradient(gradient!,
                                        start: CGPoint(x: 0, y: size.height),
                                        end: CGPoint(x: 0, y: 0),
                                        options: CGGradientDrawingOptions(rawValue: 0))
        }
        
        self.init(cgImage:(UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }
}

