/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit

class QYBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    private var _barStyle: UIStatusBarStyle?
    public var yi_barStyle: UIStatusBarStyle {
        set {
            _barStyle = newValue
            setNeedsStatusBarAppearanceUpdate()
        }
        get {
            return _barStyle ?? UIStatusBarStyle.default
        }
    }
    //返回手势
    private var _interactivePop: Bool?
    public var interactivePop: Bool {
        set {
            _interactivePop = newValue
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = newValue
        }
        get {
            return _interactivePop ?? false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //防止自动下移64
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.interactivePop = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.yi_barStyle
    }

}
