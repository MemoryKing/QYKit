/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit

class QYBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

}
