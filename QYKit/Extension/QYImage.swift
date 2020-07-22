/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation
import UIKit

public extension UIImage {
    static func url(url: String) -> UIImage? {
        var image : UIImage?
        let url = URL.init(string: url)
        do {
            let data = try Data(contentsOf: url!)
            image = UIImage.init(data: data)
        }catch let error as NSError {
            print(error)
        }
        return image
    }
    
}

//MARK: -------   渐变
public extension UIImage {
    /// 渐变色方向
    enum Direction {
        ///垂直
        case vertical
        ///水平
        case level
        ///左上到右下
        case leftTop
        ///左下到右上
        case leftBottom
    }
    ///线性渐变
    class func yi_initGradient (size : CGSize, direction : Direction,locations : Array<CGFloat> = [0.0,1.0] ,colors : [UIColor]) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        guard (context != nil) else {
            return UIImage()
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var cgColors = [CGColor]()
        colors.forEach { (colo) in
            cgColors.append(colo.cgColor)
        }
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)!
        
        var start = CGPoint()
        var end = CGPoint()
        switch direction {
        case .vertical:
            start = CGPoint.init(x: 0, y: 0)
            end = CGPoint.init(x: 0, y: size.height)
            break
        case .level :
            start = CGPoint.init(x: 0, y: 0)
            end = CGPoint.init(x: size.width, y: 0)
            break
        case .leftTop :
            start = CGPoint.init(x: 0, y: 0)
            end = CGPoint.init(x: size.width, y: size.height)
            break
        case .leftBottom :
            start = CGPoint.init(x: size.width, y: 0)
            end = CGPoint.init(x: 0, y: size.height)
            break
        }
        
        context?.drawLinearGradient(gradient, start: start, end: end, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    ///放射性渐变
    class func yi_initRadialGradients (size : CGSize,locations : Array<CGFloat> = [0.0,1.0] ,colors : [UIColor]) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        guard (context != nil) else {
            return nil
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var cgColors = [CGColor]()
        colors.forEach { (colo) in
            cgColors.append(colo.cgColor)
        }
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)!
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        //外圆半径
        let endRadius = min(size.width, size.height) / 2
        //内圆半径
        let startRadius = endRadius / 3
        //绘制渐变
        context?.drawRadialGradient(gradient,
                                   startCenter: center, startRadius: startRadius,
                                   endCenter: center, endRadius: endRadius,
                                   options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
//MARK: -------   转换
public extension UIImage {
    ///image --> base64
    func yi_toBaseString (_ quality : Float = 1,_ options : Data.Base64EncodingOptions = [.lineLength64Characters]) -> String {
        // 将图片转化成Data
        let imageData = self.jpegData(compressionQuality: CGFloat(quality))
        // 将Data转化成 base64的字符串
        let imageBase64String = imageData?.base64EncodedString(options: options) ?? ""
        return imageBase64String
    }
}
