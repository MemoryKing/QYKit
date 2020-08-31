/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import Foundation
import UIKit

open class QYTableViewDelegate: NSObject {
    ///区数
    public var numberSections: Int?
    ///区头数
    public var numberOfSections: ((UITableView)->(Int))?
    
    ///区头高
    public var heightHeaderSection: CGFloat?
    ///区头高
    public var heightForHeaderInSection: ((UITableView, Int)->(CGFloat))?
    ///区头视图
    public var viewForHeaderInSection: ((UITableView,Int)->(UIView))?
    
    ///区尾高
    public var heightFooterSection: CGFloat?
    ///区尾高
    public var heightForFooterInSection: ((UITableView, Int)->(CGFloat))?
    ///区尾视图
    public var viewForFooterInSection: ((UITableView,Int)->(UIView))?
    
    ///单元数(所有区相同)
    public var numberRows: Int?
    ///单元数
    public var numberOfRowsInSection: ((UITableView, Int)->(Int))?
    ///单元高
    public var heightRows: CGFloat?
    ///单元高
    public var heightForRowAtIndexPath: ((UITableView, IndexPath)->(CGFloat))?
    ///单元
    public var cellForRowAtIndexPath: ((UITableView, IndexPath)->(UITableViewCell))?
    ///单元点击
    public var didSelectRowAtIndexPath: ((UITableView, IndexPath)->())?
    
    ///数据
    public var dataArray: Array? = []
}

extension QYTableViewDelegate : UITableViewDelegate,UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if numberOfSections != nil {
            return numberOfSections!(tableView)
        }
        if numberSections != nil {
            return numberSections!
        }
        return tableView.numberOfSections == 0 ? 1 : tableView.numberOfSections
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if heightForHeaderInSection != nil {
            return heightForHeaderInSection!(tableView,section)
        }
        if heightHeaderSection != nil {
            return heightHeaderSection!
        }
        return tableView.sectionHeaderHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return viewForHeaderInSection?(tableView,section) ?? UIView.init()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if numberOfRowsInSection != nil {
            return numberOfRowsInSection!(tableView,section)
        }
        if numberRows != nil {
            return numberRows!
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if heightForRowAtIndexPath != nil {
            return heightForRowAtIndexPath!(tableView,indexPath)
        }
        if heightRows != nil {
            return heightRows!
        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellForRowAtIndexPath != nil {
            return cellForRowAtIndexPath!(tableView,indexPath)
        }
        return UITableViewCell.init()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPath?(tableView,indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if heightForFooterInSection != nil {
            return heightForFooterInSection!(tableView,section)
        }
        if heightFooterSection != nil {
            return heightFooterSection!
        }
        return tableView.sectionFooterHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewForFooterInSection?(tableView,section) ?? UIView.init()
    }
    
}
