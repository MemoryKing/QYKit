/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit
import Foundation

public extension UIButton {
    ///倒计时
    var yi_countdown: QYCountDownButton {
        return QYCountDownButton.shared
    }
}

public extension NSObject {
    ///时间选择器
    var yi_datePicker: QYDatePickerViewController {
        return QYDatePickerViewController()
    }
}
