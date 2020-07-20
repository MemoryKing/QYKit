/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import Foundation
import UIKit

//MARK: ---------- 设置导航 ----------
extension UIViewController {
    public var yi_hiddenShadow : Bool? {
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
    
    ///隐藏导航
    public var yi_NavBarHidden: Bool {
        get {
            return (navigationController?.isNavigationBarHidden)!
        }
        set {
            navigationController?.isNavigationBarHidden = newValue
        }
    }
    
    ///导航透明
    public func yi_navClear () {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    ///返回图片
    public func yi_backImage (_ img : UIImage) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            if self.navigationController!.children.count > 1 {
                yi_navLeftImageItem(img) {
                    self.yi_goBack()
                }
            }
        }
    }
    
    ///导航背景色
    public func yi_navBackground (_ color :UIColor) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            self.navigationController?.navigationBar.barTintColor = color
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    ///文本
    public func yi_navTitle (_ title : String,_ font : CGFloat = 18,_ color: UIColor = .black) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            self.navigationItem.title = title
            let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: font)]
            self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedString.Key : AnyObject]
        }
    }
    
    ///左文本按钮
    public func yi_navLeftTitleItem (_ title: String,_ color: UIColor = .black,navBlk : @escaping ()->()) {
        let leftItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(navLeftItemClick))
        leftItem.tintColor = color
        self.navigationItem.leftBarButtonItem = leftItem
        leftNavBlock = navBlk
    }
    
    ///左图片按钮
    public func yi_navLeftImageItem (_ image: UIImage,_ navBlk: @escaping ()->()) {
        let leftItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navLeftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        leftNavBlock = navBlk
    }
    
    ///左图文
    public func yi_navLeftTitleAndImageItem (_ title : String? , _ color : UIColor = .black,_ font : UIFont? = UIFont.systemFont(ofSize: 17),_ image : UIImage? = nil,_ navBlk: @escaping ()->()) {
        let item = self.customBarButtonItem(title, color, font, image, #selector(navLeftItemClick))
        self.navigationItem.leftBarButtonItem = item
        leftNavBlock = navBlk
    }

    ///右文本按钮
    public func yi_navRightTitleItem (_ title: String,_ color: UIColor = .black,navBlk : @escaping ()->()) {
        let rightItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(navRightItemClick))
        rightItem.tintColor = color
        
        self.navigationItem.rightBarButtonItem = rightItem
        rightNavBlock = navBlk
    }
    
    ///右图片按钮
    public func yi_navRightImageItem (_ image: UIImage,_ navBlk: @escaping ()->()) {
        let rightItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navRightItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
        rightNavBlock = navBlk
    }
    
    ///左图文
    public func yi_navRightTitleAndImageItem (_ title : String? , _ color : UIColor = .black,_ font : UIFont? = UIFont.systemFont(ofSize: 17),_ image : UIImage? = nil,_ navBlk: @escaping ()->()) {
        let item = self.customBarButtonItem(title, color, font, image, #selector(navRightItemClick))
        self.navigationItem.rightBarButtonItem = item
        rightNavBlock = navBlk
    }
}

//MARK: -------   跳转
extension UIViewController {
    ///跳转
    public func yi_push(_ viewController: UIViewController,_ animated: Bool = true) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            if self.navigationController!.children.count > 0 {
                viewController.hidesBottomBarWhenPushed = true
            }
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    ///返回
    public func yi_goBack (_ ani : Bool = true) {
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

    ///返回某视图
    public func yi_goBackToVC (_ num : Int = 0,_ ani : Bool = true) {
        if self.navigationController == nil {
            NSLog("no navigation controller", 1)
        } else {
            guard let vc = self.navigationController?.viewControllers[num] else { return }
            self.navigationController?.popToViewController(vc, animated: ani)
        }
    }
    
    ///返回首页
    public func yi_backToRootControlelr (_ ani : Bool) {
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
}

//MARK: -------   私有
extension UIViewController {
    
    @objc private func navLeftItemClick () {
        leftNavBlock?()
    }
    
    @objc private func navRightItemClick () {
        rightNavBlock?()
    }
    
    //自定义barItem
    private func customBarButtonItem (_ title : String? , _ color : UIColor = .black,_ font : UIFont? = UIFont.systemFont(ofSize: 17),_ image : UIImage? = nil,_ block : Selector) -> UIBarButtonItem {
        let button = UIButton().yi_init {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(color, for: .normal)
            $0.setImage(image, for: .normal)
            $0.titleLabel?.font = font
            $0.addTarget(self, action: block, for: .touchUpInside)
        }
        return UIBarButtonItem.init(customView: button)
    }
}

extension UIViewController {
    struct RuntimeKey {
        static let leftKey = UnsafeRawPointer.init(bitPattern: "leftKey".hashValue)
        static let rightKey = UnsafeRawPointer.init(bitPattern: "rightKey".hashValue)
        static let titleColorKey = UnsafeRawPointer.init(bitPattern: "titleColorKey".hashValue)
        static let hiddenShadowKey = UnsafeRawPointer.init(bitPattern: "hiddenShadowKey".hashValue)
    }
    
    private var leftNavBlock: (() -> ())? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.leftKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  (objc_getAssociatedObject(self, RuntimeKey.leftKey!) as! (() -> ()))
        }
    }
    
    private var rightNavBlock: (() -> ())? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.rightKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, RuntimeKey.rightKey!) as! (() -> ()))
        }
    }
}
