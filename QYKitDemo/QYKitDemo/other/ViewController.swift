//
//  ViewController.swift
//  YJSwiftKit
//
//  Created by Mac on 2020/6/19.
//  Copyright © 2020 祎. All rights reserved.
//

import UIKit
//import PKHUD
//import QYKit


class ViewController: QYBaseViewController {
    var tableView: UITableView!
    var lab: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
//        ceshi()
        ceshi1()
    }
    func ceshi1() {
        tableView = UITableView(frame: view.bounds)
        tableView.backgroundColor = .blue
        view.addSubview(tableView)
        tableView.yi_viewForHeaderInSection({ (tab, sec) -> UIView in
            let view = UIView()
            if sec == 0 {
                view.backgroundColor = .red
            } else {
                view.backgroundColor = .gray
            }
            return view
        }).yi_numberOfSections({ (tab) -> (Int) in
            return 10
        }).yi_heightHeaderSection(100)
        
        tableView.yi_viewForFooterInSection { (tab, sec) -> UIView in
            let view = UIView()
            view.backgroundColor = .purple
            if sec == 1 {
                view.backgroundColor = .gray
            }
            return view
        }.yi_heightFooterSection(30)
        
        tableView.yi_didSelectRowAtIndexPath { (tab, indexPath) in
            QYLog(indexPath)
        }
        
    }
    
    func ceshi() {
//        la.frame = .init(x: 0, y: 0, width: 200, height: 200)
//        la.center = self.view.center
//        la.text = "创建来到测试世界"
//        self.view.addSubview(la)
//
//        la.yi_setGradientLayer(direction: .leftBottom, colors: [.blue,.red])
//        la.yi_configRectCorner(radii: .init(width: 30, height: 30))
//        la.layer.masksToBounds = true
//        let img = UIImageView().Yi_init {
//            self.view.addSubview($0)
//            $0.backgroundColor = .blue
//            $0.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
//        }
        
        
//        img.image = UIImage.initGradient(size: .init(width: 100, height: 100), direction: .leftTop, colors: [.blue,.red])
//        img.yi_addBorderTop(size: 10, color: .blue)
        self.view.backgroundColor = .blue
//        let string = "adcfb425723432".yi_xor("213871248dbcaf")
//        yPrintLog(string.yi_hexToString())
//        QYLog("text=text".yi_toURLEncode("="))
        let lab = QYCountDownButton().yi_then {
            $0.frame = .init(x: 100, y: 100, width: 100, height: 100)
            $0.yi_title = "获取验证码"
            $0.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
        }
        self.view.addSubview(lab)
        
        _ = CGSize.init(width: 1, height: 1) + CGSize.init(width: 1, height: 1)
    }
    
    @objc func click (_ btn: QYCountDownButton) {
        QYDatePickerViewController.yi_showDatePicker(.year) { (st) in
            
        }
//        QYAlert.yi_show(message: "打", titleArr: ["123","qwe"], highlighted: 1, handler: { (alert,action,i) in
//            if i == 0 {
//                action.setValue(QY99Color, forKey: "titleTextColor")
//            }
//            alert.yi_titleColor = .cyan
//            alert.yi_titleFont = QYFont_23
//            alert.yi_messageColor = .green
//            alert.yi_messageFont = QYFont_22
//            action.yi_titleColor = .red
//            QYLog(action.yi_get_class_copyPropertyList())
//            QYLog(action.yi_get_class_copyMethodList())
//            action.yi_image = UIImage.init(named: "矩形 490")
//            
//        }) { (i, s) -> (Void) in
//            
//        }
//        QYLog(["12","34","56","78"][[0,3,7]])
    }
}

