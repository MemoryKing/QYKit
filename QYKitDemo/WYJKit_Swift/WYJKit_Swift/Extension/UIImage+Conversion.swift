/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/

import Foundation
import UIKit


public extension UIImage {
    ///base64
    func toBase64 () -> (String) {
        let imgData = self.pngData()
        let baseImage = imgData == nil ? "" : imgData!.base64EncodedString()
        return baseImage
    }
    
    ///jpeg
    func toJPEGData(quarity: CGFloat = 1.0) -> Data? {
        return self.jpegData(compressionQuality: quarity)
    }
    
    ///png
    func toPNGData(quarity: CGFloat = 1.0) -> Data? {
        return self.pngData()
    }
}

