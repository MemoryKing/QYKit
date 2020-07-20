/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation
import UIKit

class QYSystemManager: NSObject {
    
    //MARK: -------   拨打电话
    class func openPhone(_ phone : String,_ completion: ((Bool) -> Void)? = nil) {
        if UIApplication.shared.canOpenURL(URL(string: "tel://" + phone)!) {
            UIApplication.shared.open(URL(string: "tel://" + phone)!, options: [:], completionHandler: completion)
        }
    }
    
    //MARK: -------   打开设置
    class func openSettings(_ completion: ((Bool) -> Void)? = nil) {
        let url = URL.init(string: UIApplication.openSettingsURLString)
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: completion)
        }

    }
    
}
