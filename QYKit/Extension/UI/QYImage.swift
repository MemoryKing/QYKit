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
            if let ur = url {
                let data = try Data(contentsOf: ur)
                image = UIImage.init(data: data)
            }
        } catch let error as NSError {
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
    func yi_quality(_ quality: Float? = nil) -> UIImage? {
        guard let imageData = self.jpegData(compressionQuality: CGFloat(quality ?? 1)) else { return nil }
        return UIImage.init(data: imageData)
    }
    ///image --> base64
    func yi_toBase64 (_ options: Data.Base64EncodingOptions = [.endLineWithLineFeed]) -> String {
        // 将图片转化成Data
        let imageData = self.yi_quality()?.jpegData(compressionQuality: 1)
        // 将Data转化成 base64的字符串
        let imageBase64String = imageData?.base64EncodedString(options: options) ?? ""
        return imageBase64String
    }
    ///image --> color
    func yi_toColor() -> UIColor? {
        return UIColor.init(patternImage: self)
    }
}
//MARK: --- 功能
public extension UIImage {
     /// 截取指定Image的rect
     func yi_indexCrop(_ rect: CGRect) -> UIImage {
         guard rect.size.height < size.height && rect.size.height < size.height else { return self }
         guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
         return UIImage(cgImage: image)
     }
     ///图片质量
     func yi_compressionQuality(_ quality: CGFloat = 0.5) -> UIImage? {
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
    ///图片压缩
    func yi_resetImage(_ maxSizeKB : CGFloat,_ maxImageLenght : CGFloat?) -> UIImage? {
        let maxSize = maxSizeKB
        let maxImageSize = maxImageLenght ?? self.size.width
        //先调整分辨率
        var newSize = CGSize.init(width: self.size.width, height: self.size.height)
        let tempHeight = newSize.height / maxImageSize
        let tempWidth = newSize.width / maxImageSize
        if (tempWidth > 1.0 && tempWidth > tempHeight) {
            newSize = CGSize.init(width: self.size.width / tempWidth, height: self.size.height / tempWidth)
        }
        else if (tempHeight > 1.0 && tempWidth < tempHeight){
            newSize = CGSize.init(width: self.size.width / tempHeight, height: self.size.height / tempHeight)
        }
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        var imageData = newImage!.jpegData(compressionQuality: 1.0)
        var sizeOriginKB : CGFloat = CGFloat((imageData?.count)!) / 1024.0
        //调整大小
        var resizeRate = 0.9
        while (sizeOriginKB > maxSize && resizeRate > 0.1) {
            imageData = newImage!.jpegData(compressionQuality: CGFloat(resizeRate))
            sizeOriginKB = CGFloat((imageData?.count)!) / 1024.0
            resizeRate -= 0.1
        }
        QYLog("压缩后图片--大小:\(sizeOriginKB)--size:\(newSize)")
        if let data = imageData {
            return UIImage.init(data: data)
        } else {
            return nil
        }
    }
    
    ///将图片绘制成制定大小
    func yi_scale(_ w: CGFloat,_ h: CGFloat) -> UIImage? {
        let newSize = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
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
        
        return newImage
    }
    
     /// 根据字符串生成二维码图片
     class func yi_generateQRImage(_ QRCodeString: String,_ logo: UIImage?,_ size: CGSize = CGSize(width: 200, height: 200)) -> UIImage? {
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
    ///生成条形码
    class func generateCode128(_ text:String, _ size:CGSize,_ color:UIColor? = nil ) -> UIImage? {
        //给滤镜设置内容
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setDefaults()
            filter.setValue(data, forKey: "inputMessage")
            //获取生成的条形码
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            // 设置条形码颜色
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            //获取带颜色的条形码
            guard let newOutPutImage = colorFilter?.outputImage else {
                return nil
            }
            let scaleX:CGFloat = size.width/newOutPutImage.extent.width
            let scaleY:CGFloat = size.height/newOutPutImage.extent.height
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            let output = newOutPutImage.transformed(by: transform)
            let barCodeImage = UIImage(ciImage: output)
            return barCodeImage
        }
        return nil
    }
    ///保存到相册
    func yi_savedPhotosAlbum() {
        UIImageWriteToSavedPhotosAlbum(self, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
    }
       
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil{
            QYHUD.show("保存失败")
        }else{
            print("保存成功")
            QYHUD.show("保存成功")
        }
    }
}



public extension UIImage {
    private struct QYRuntimeKey {
        static let saveBlockKey = UnsafeRawPointer.init(bitPattern: <#T##Int#>)
    }
}
