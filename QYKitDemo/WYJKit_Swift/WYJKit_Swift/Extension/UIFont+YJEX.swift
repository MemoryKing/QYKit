//
//  File.swift
//  Express
//
//  Created by 祎 on 2019/7/23.
//  Copyright © 2019 祎. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    static let IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
    static let IPAD = (UIDevice.current.userInterfaceIdiom == .pad)
    static let IPHONE5 = (IPHONE && UIScreen.main.bounds.size.height == 568.0)
    static let IPHONE6 = (IPHONE && UIScreen.main.bounds.size.height == 667.0)
    static let IPHONEPLUS = (IPHONE && UIScreen.main.bounds.size.height == 736.0)
    static let IPHONEX = (IPHONE && UIScreen.main.bounds.size.height > 780.0)
    
    static func WFontWithSize(_ font: CGFloat) -> (UIFont){
        let size : CGFloat = IPHONE5 ? -2.0 : IPHONEX ? 2.0 : 0.0
        return UIFont.systemFont(ofSize: font + size)
    }
    
    static func WBoldWithSize(_ font: CGFloat) -> (UIFont){
        let size : CGFloat = IPHONE5 ? -2.0 : IPHONEX ? 2.0 : 0.0
        return UIFont.boldSystemFont(ofSize: size + font)
    }
}
