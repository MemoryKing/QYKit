/*******************************************************************************
 Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ (Wang Yijing)
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/MemoryKing
 ********************************************************************************/

import Foundation
import UIKit

//MARK: ---------- view Controller ----------
public extension UIViewController {
    /** hidder nav */
    func setNavHidder(_ hidder: Bool) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            self.navigationController!.setNavigationBarHidden(hidder, animated: true)
        }
    }
    
    /** setting nav clear */
    func setNavClear () {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    func setBackImage (_ img : UIImage) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            if self.navigationController!.children.count > 1 {
                setNavLeftItemImage(img) {
                    self.goBack(true)
                }
            }
        }
    }
    
    /** setting nav background */
    func setNavBackground (_ color :UIColor) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            self.navigationController?.navigationBar.barTintColor = color
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    /** setting up nav title */
    func setNavTitle (_ title : String) {
        if (titleColor != nil) {
            self .setNavTitle(title: title, color: titleColor!)
        } else {
            self .setNavTitle(title: title, color: UIColor.black)
        }
    }
    
    /** setting up nav title and title color */
    func setNavTitle (title: String,color: UIColor) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            self.navigationItem.title = title
            let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
            self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        }
    }
    
    /** setting up left item title */
    func setNavLeftItemTitle (_ title: String,_ navBlk : @escaping ()->()) {
        let leftItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(navLeftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
        leftNavBlock = navBlk
    }
    
    /** setting up left item title color*/
    func setNavLeftItemTitle (title: String,color: UIColor,navBlk : @escaping ()->()) {
        let leftItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(navLeftItemClick))
        leftItem.tintColor = color
        self.navigationItem.leftBarButtonItem = leftItem
        leftNavBlock = navBlk
    }
    
    /** setting up left item image*/
    func setNavLeftItemImage (_ image: UIImage,_ navBlk: @escaping ()->()) {
        let leftItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navLeftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        leftNavBlock = navBlk
    }
    
    /** setting up right item title */
    func setNavRightItemTitle (_ title: String,_ navBlk : @escaping ()->()) {
        let rightItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(navRightItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
        rightNavBlock = navBlk
    }
    
    /** setting up right item title color*/
    func setNavRightItemTitle (title: String,color: UIColor,navBlk : @escaping ()->()) {
        let rightItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(navRightItemClick))
        rightItem.tintColor = color
        self.navigationItem.rightBarButtonItem = rightItem
        rightNavBlock = navBlk
    }
    
    /** setting up right item image*/
    func setNavRightItemImage (_ image: UIImage,_ navBlk: @escaping ()->()) {
        let rightItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navRightItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
        rightNavBlock = navBlk
    }
    
    /** push vc*/
    func pushVController(_ viewController: UIViewController, animated: Bool) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            if self.navigationController!.children.count > 0 {
                viewController.hidesBottomBarWhenPushed = true
            }
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    /** back */
    func goBack () {
        goBack(true)
    }
    
    func goBack (_ ani : Bool) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            if ((self.navigationController?.viewControllers.count)! > 1) {
                self.navigationController?.popViewController(animated: ani)
            }
            else if ((self.presentingViewController) != nil) {
                self.dismiss(animated: ani, completion: nil)
            }
        }
    }
    
    /** pop to root vc */
    func popOrDismissToRootControlelr () {
        popOrDismissToRootControlelr(true)
    }
    
    /** pop to root vc */
    func popOrDismissToRootControlelr (_ ani : Bool) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            if ((self.navigationController?.viewControllers.count)! > 1) {
                self.navigationController?.popToRootViewController(animated: ani)
            }
            else if ((self.presentingViewController) != nil) {
                self.dismiss(animated: ani, completion: nil)
            }
        }
    }
    
    /** pop vc */
    func popViewController(animated: Bool) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    @objc func navLeftItemClick () {
        leftNavBlock?()
    }
    
    @objc func navRightItemClick () {
        rightNavBlock?()
    }
    
}

public extension UIViewController {
    struct RuntimeKey {
        static let leftKey = UnsafeRawPointer.init(bitPattern: "leftKey".hashValue)
        static let rightKey = UnsafeRawPointer.init(bitPattern: "rightKey".hashValue)
        static let titleColorKey = UnsafeRawPointer.init(bitPattern: "titleColorKey".hashValue)
        static let hiddenShadowKey = UnsafeRawPointer.init(bitPattern: "hiddenShadowKey".hashValue)
    }
    
    var leftNavBlock: (() -> ())? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.leftKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  (objc_getAssociatedObject(self, RuntimeKey.leftKey!) as! (() -> ()))
        }
    }
    
    var rightNavBlock: (() -> ())? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.rightKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, RuntimeKey.rightKey!) as! (() -> ()))
        }
    }
    
    var titleColor : UIColor? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.titleColorKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, RuntimeKey.titleColorKey!) as! UIColor)
        }
    }
    
    var hiddenShadow : Bool? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.hiddenShadowKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            if (newValue != nil) {
                if self.navigationController == nil {
                    NSLog("no navigation controller", 1)
                } else {
                    self.navigationController?.navigationBar.shadowImage = UIImage()
                }
            }
        }
        get {
            return (objc_getAssociatedObject(self, RuntimeKey.hiddenShadowKey!) as! Bool)
        }
    }
}
