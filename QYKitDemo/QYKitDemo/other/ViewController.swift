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


class ViewController: QYBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    var lab: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        QYLog("text=text".yi_toURLEncode("="))
        let lab = QYCountDownButton().yi_then {
            $0.frame = .init(x: 100, y: 100, width: 100, height: 100)
            $0.yi_title = "获取验证码"
            $0.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
        }
        self.view.addSubview(lab)
        
        _ = CGSize.init(width: 1, height: 1) + CGSize.init(width: 1, height: 1)
        
        
//        self.yi_addTableView {
//            $0.backgroundColor = .red
//        }
        
        UIButton().yi_then({
            $0.yi_imagePosition(.right, 1)
        })
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

//MARK: --- TableViewDelegate
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
}
