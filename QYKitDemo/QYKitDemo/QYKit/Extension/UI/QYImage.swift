/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation
import UIKit

public extension UIImage {
    ///加载url
    static func yi_url(url: String) -> UIImage? {
        var image: UIImage?
        let url = URL.init(string: url)
        do {
            let data = try Data(contentsOf: url!)
            image = UIImage.init(data: data)
        }catch let error as NSError {
            print(error)
        }
        return image
    }
    /// 根据view 生成image
    convenience init?(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    ///根据颜色生成图片
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
}

//MARK: --- 渐变
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
    class func yi_initGradient (size: CGSize,
                                direction: Direction,
                                locations: Array<CGFloat> = [0.0,1.0] ,
                                colors: [UIColor]) -> UIImage {
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
        case .level:
            start = CGPoint.init(x: 0, y: 0)
            end = CGPoint.init(x: size.width, y: 0)
            break
        case .leftTop:
            start = CGPoint.init(x: 0, y: 0)
            end = CGPoint.init(x: size.width, y: size.height)
            break
        case .leftBottom:
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
    class func yi_initRadialGradients (size: CGSize,
                                       locations: Array<CGFloat> = [0.0,1.0],
                                       colors: [UIColor]) -> UIImage? {
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
//MARK: --- 转换
public extension UIImage {
    ///image --> base64
    func yi_toBaseString (_ quality: Float = 1,
                          _ options: Data.Base64EncodingOptions = [.lineLength64Characters]) -> String {
        // 将图片转化成Data
        let imageData = self.jpegData(compressionQuality: CGFloat(quality))
        // 将Data转化成 base64的字符串
        let imageBase64String = imageData?.base64EncodedString(options: options) ?? ""
        return imageBase64String
    }
}
//MARK: --- 功能
public extension UIImage {
    ///将图片绘制成制定大小
     class func yi_scale(_ image: UIImage,_ w: CGFloat,_ h: CGFloat) -> UIImage {
         let newSize = CGSize(width: w, height: h)
         UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
         image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
         let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
         UIGraphicsEndImageContext()
         return newImage
     }
     
     ///颜色生成image
     class func yi_fromColor(_ color:UIColor) -> UIImage {
         let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
         UIGraphicsBeginImageContext(rect.size);
         let context = UIGraphicsGetCurrentContext()
         context!.setFillColor(color.cgColor);
         context!.fill(rect)
         let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
         UIGraphicsEndImageContext()
         
         return newImage;
     }
     /// 截取指定Image的rect
     func yi_indexCrop(_ rect: CGRect) -> UIImage {
         guard rect.size.height < size.height && rect.size.height < size.height else { return self }
         guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
         return UIImage(cgImage: image)
     }
    ///view生成指定大小的图片
    func yi_fromView(_ view:UIView ,_ size:CGSize) -> UIImage {
         
         UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
         view.layer.render(in: UIGraphicsGetCurrentContext()!)
         
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         return image!
     }
     ///压缩图片
     func yi_compressedData(_ quality: CGFloat = 0.5) -> UIImage? {
        return UIImage.init(data: self.jpegData(compressionQuality: quality)!)
     }
     /// 旋转指定角度
     func yi_rotate(_ radians: Float) -> UIImage {
         let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
         let transformation: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(radians))
         rotatedViewBox.transform = transformation
         let rotatedSize: CGSize = CGSize(width: Int(rotatedViewBox.frame.size.width), height: Int(rotatedViewBox.frame.size.height))
         UIGraphicsBeginImageContextWithOptions(rotatedSize, false, 0)
         guard let context: CGContext = UIGraphicsGetCurrentContext() else {
             UIGraphicsEndImageContext()
             return self
         }
         context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
         context.rotate(by: CGFloat(radians))
         context.scaleBy(x: 1.0, y: -1.0)
         context.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
         guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
             UIGraphicsEndImageContext()
             return self
         }
         UIGraphicsEndImageContext()
         return newImage
     }
     /// 根据字符串生成二维码图片
     func yi_generateQRImage(_ QRCodeString: String,_ logo: UIImage?,_ size: CGSize = CGSize(width: 200, height: 200)) -> UIImage? {
         guard let data = QRCodeString.data(using: .utf8, allowLossyConversion: false) else {
             return nil
         }
         let imageFilter = CIFilter(name: "CIQRCodeGenerator")
         imageFilter?.setValue(data, forKey: "inputMessage")
         imageFilter?.setValue("H", forKey: "inputCorrectionLevel")
         let ciImage = imageFilter?.outputImage
         // 创建颜色滤镜
         let colorFilter = CIFilter(name: "CIFalseColor")
         colorFilter?.setDefaults()
         colorFilter?.setValue(ciImage, forKey: "inputImage")
         colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
         colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
         // 返回二维码图片
         let qrImage = UIImage(ciImage: (colorFilter?.outputImage)!)
         let imageRect = size.width > size.height ?
             CGRect(x: (size.width - size.height) / 2, y: 0, width: size.height, height: size.height) :
             CGRect(x: 0, y: (size.height - size.width) / 2, width: size.width, height: size.width)
         UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
         defer {
             UIGraphicsEndImageContext()
         }
         qrImage.draw(in: imageRect)
         if logo != nil {
             let logoSize = size.width > size.height ?
                 CGSize(width: size.height * 0.25, height: size.height * 0.25) :
                 CGSize(width: size.width * 0.25, height: size.width * 0.25)
             logo?.draw(in: CGRect(x: (imageRect.size.width - logoSize.width) / 2, y: (imageRect.size.height - logoSize.height) / 2, width: logoSize.width, height: logoSize.height))
         }
         return UIGraphicsGetImageFromCurrentImageContext()
     }
}
