//
//  QYConfigurable.swift
//  QYKitDemo
//
//  Created by 祎 on 2020/12/4.
//  Copyright © 2020 祎. All rights reserved.
//

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

