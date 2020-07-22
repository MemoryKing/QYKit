/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit


public extension String {
    ///base64  转出图片
    func baseImage() -> UIImage {
        let imageData : NSData! = NSData.init(base64Encoded: self, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        
        return UIImage.init(data: imageData as Data)!
    }
    
}
