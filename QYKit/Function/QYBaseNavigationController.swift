/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit

public class QYBaseNavigationController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

}
