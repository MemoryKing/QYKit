/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit

///自定义视图
public extension UIView {
    ///自定义弹窗
    func showCustomAlertView (title : String?, message : String?, datas : [String], handler: ((String) -> Void)? = nil) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        for str in datas {
            let action = UIAlertAction.init(title: str, style: UIAlertAction.Style.default) { (action) in
                if handler != nil {
                    handler!(action.title!)
                }
            }
            
            alertVC.addAction(action)
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.default) { (action) in
            
        }
        
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true)
    }
}
