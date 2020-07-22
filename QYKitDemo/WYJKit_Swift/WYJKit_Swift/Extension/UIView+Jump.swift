/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/


import Foundation
import UIKit

//MARK:   -------   跳转 ----------
public extension UIView {
    func push(_ vc: UIViewController) {
        let currentC = currentController()
        
        if currentController() == nil {
            NSLog("current controller is nil")

        } else {
            if currentC!.isKind(of: UINavigationController.self) {
                let nav: UINavigationController = currentC as! UINavigationController
                if nav.viewControllers.count > 0 {
                    vc.hidesBottomBarWhenPushed = true
                }
                nav.pushViewController(vc, animated: true)
                
            } else {
                let nav: UINavigationController = currentC!.navigationController!
                if nav.viewControllers.count > 0 {
                    vc.hidesBottomBarWhenPushed = true
                }
                currentC!.navigationController!.pushViewController(vc, animated: true)
            }
        }
    }
    
    func pop() {
        let currentC = currentController()
        if currentController() == nil {
            NSLog("current controller is nil")
            
        } else {
            if currentC!.isKind(of: UINavigationController.self) {
                ((currentC as? UINavigationController))?.popViewController(animated: true)
                
            } else {
                currentC!.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func popToRoot() {
        popToRootWithAnimated(true)
    }
    
    func popToRootWithAnimated(_ animated: Bool) {
        let currentC = currentController()
        if currentController() == nil {
            NSLog("current controller is nil")
            
        } else {
            if currentC!.isKind(of: UINavigationController.self) {
                (currentC as! UINavigationController).popToRootViewController(animated: true)
                
            } else {
                currentC!.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func present(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    func present(_ vc: UIViewController, animated: Bool) {
        if currentController() == nil {
            NSLog("current controller is nil")
        } else {
            currentController()?.present(vc, animated: animated, completion: nil)
        }
    }
    
    func dismiss() {
        dismissAnimated(true)
        
    }
    
    func dismissAnimated(_ animated: Bool) {
        if currentController() == nil {
            NSLog("current controller is nil")
            
        } else {
            currentController()? .dismiss(animated: animated, completion: nil)
        }
    }
    
    func currentController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UINavigationController.self) {
                    let tab = responder as! UINavigationController
                    return tab.visibleViewController
                    
                } else if responder.isKind(of: UITabBarController.self) {
                    let tab = responder as! UITabBarController
                    return tab.selectedViewController
                    
                } else if responder.isKind(of: UIViewController.self) {
                    let vc = responder as! UIViewController
                    return vc
                }
            }
        }
        return nil
    }
}


//MARK:   -------   属性 ----------
extension UIView {
    struct RuntimeKey {
        static let photoPicker = UnsafeRawPointer.init(bitPattern: "photoPicker".hashValue)
        static let photoBlockKey    = UnsafeRawPointer.init(bitPattern: "photoBlock".hashValue)
    }
    
    var photosPicker : UIImagePickerController {
        set {
            objc_setAssociatedObject(self, RuntimeKey.photoPicker!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, RuntimeKey.photoPicker!) as! UIImagePickerController
        }
    }
    
    var photoBlock : ((UIImage)->()) {
        set {
            objc_setAssociatedObject(self, RuntimeKey.photoBlockKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, RuntimeKey.photoBlockKey!) as! ((UIImage)->())
        }
    }
}
