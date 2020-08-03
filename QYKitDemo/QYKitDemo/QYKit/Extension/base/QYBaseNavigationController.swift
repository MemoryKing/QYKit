/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit

open class QYBaseNavigationController: UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()

    }
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

}
