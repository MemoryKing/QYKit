//
//  File.swift
//  QYKitDemo
//
//  Created by 祎 on 2020/8/25.
//  Copyright © 2020 祎. All rights reserved.
//

import Foundation
import UIKit

public class QYTableViewDelegate: NSObject {
    ///区数
    var numberSections: Int?
    ///区头数
    var numberOfSections: ((UITableView)->(Int))?
    
    ///区头高
    var heightHeaderSection: CGFloat?
    ///区头高
    var heightForHeaderInSection: ((UITableView, Int)->(CGFloat))?
    ///区头视图
    var viewForHeaderInSection: ((UITableView,Int)->(UIView))?
    
    ///区尾高
    var heightFooterSection: CGFloat?
    ///区尾高
    var heightForFooterInSection: ((UITableView, Int)->(CGFloat))?
    ///区尾视图
    var viewForFooterInSection: ((UITableView,Int)->(UIView))?
    
    ///单元数(所有区相同)
    var numberRows: Int?
    ///单元数
    var numberOfRowsInSection: ((UITableView, Int)->(Int))?
    ///单元高
    var heightRows: CGFloat?
    ///单元高
    var heightForRowAtIndexPath: ((UITableView, IndexPath)->(CGFloat))?
    ///单元
    var cellForRowAtIndexPath: ((UITableView, IndexPath)->(UITableViewCell))?
    ///单元点击
    var didSelectRowAtIndexPath: ((UITableView, IndexPath)->())?
    
    ///数据
    var dataArray: Array? = []
}

extension QYTableViewDelegate : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if numberOfSections != nil {
            return numberOfSections!(tableView)
        }
        if numberSections != nil {
            return numberSections!
        }
        return tableView.numberOfSections == 0 ? 1 : tableView.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if heightForHeaderInSection != nil {
            return heightForHeaderInSection!(tableView,section)
        }
        if heightHeaderSection != nil {
            return heightHeaderSection!
        }
        return tableView.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return viewForHeaderInSection?(tableView,section) ?? UIView.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if numberOfRowsInSection != nil {
            return numberOfRowsInSection!(tableView,section)
        }
        if numberRows != nil {
            return numberRows!
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if heightForRowAtIndexPath != nil {
            return heightForRowAtIndexPath!(tableView,indexPath)
        }
        if heightRows != nil {
            return heightRows!
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellForRowAtIndexPath != nil {
            return cellForRowAtIndexPath!(tableView,indexPath)
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPath?(tableView,indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if heightForFooterInSection != nil {
            return heightForFooterInSection!(tableView,section)
        }
        if heightFooterSection != nil {
            return heightFooterSection!
        }
        return tableView.sectionFooterHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewForFooterInSection?(tableView,section) ?? UIView.init()
    }
    
}
