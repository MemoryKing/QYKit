/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 *******************************************************************************/


import Foundation
import UIKit

@objc public protocol QYConfigurable {
    func yi_configure(_ model: Any?)
}

extension UITableViewCell: QYConfigurable {
    public func yi_configure(_ model: Any?) {  }
}

extension UICollectionReusableView: QYConfigurable {
    public func yi_configure(_ model: Any?) {  }
}

