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


struct Presonewe: QYCodable {
    var name: QYStrInt?
    var ss: QYStrDble?
//    init(from decoder: Decoder) throws {
//        name = try TStrInt.init(from: decoder)
//    }
}

class ViewController: QYBaseViewController {
    var tableView: QYBaseTableView!
    var lab: UILabel?
    
    var model : Presonewe?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .lightGray
        
        var ss = "123133wqer"
        let aa = ss.yi_deleteLast()
        
        QYLog("\(ss) + \(aa)")
        
        let str = "{\"ss\":\"0.003880\",\"name\":null}"
        model = try? Presonewe.yi_init(str.yi_toDictionary())
        
        QYLog(model?.name?.string ?? "123")
        QYLog(model?.ss?.string ?? "0.0000000")
        QYLog(model?.ss?.double ?? 0.0000000)
        
//        ceshi3()
    }
    func ceshi3() {
        let brn = UIButton.init().yi_then({
            $0.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            $0.frame = self.view.bounds
            view.addSubview($0)
        })
        brn.yi_clickAction = {
//            QYHUD.shared.locationStatus = .top
            QYHUD.show("这下吧发是这下吧发是这下吧发是这下吧发是") {
                QYLog("12333333333333333333")
                self.yi_push(MyViewController())
            }
//            QYHUD.showProgress()
//            let cam = QYCameraController()
//            self.yi_push(cam)
//            self.yi_present(cam.yi_then({
////                $0.titleText = "213hndnsajif"
//                $0.modalPresentationStyle = .fullScreen
////                $0.photoType = .reverse
//            }))
//            cam.yi_cameraDidFinishShoot = {
//                brn.yi_backgroundImage = $0
//            }
            
        }
    }
    func ceshi2() {
        let page = QYPageView().yi_then({
            $0.lineColor = .red
            $0.lineSpacing = 9
            $0.lineWidth = 20
            $0.backgroundColor = .blue
            view.addSubview($0)
            $0.yi_viewControllers = [MyViewController(),MyViewController(),MyViewController(),MyViewController(),MyViewController(),MyViewController()]
        })
        page.snp.makeConstraints({
            $0.top.equalTo(QYStatusHeight)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(-QYBottomHeight)
        })
        page.yi_createPage(["都是","无去的啊","无去的","㡒豆捞坊什么","㡒经济法可什么","为福克斯的从自行车"]) { (str, i) in
            QYLog("\(str)" + "\(i)")
        }
    }
    func ceshi1() {
        tableView = QYBaseTableView(frame: view.bounds)
        tableView.yi_empty_title = "123"
        tableView.backgroundColor = .blue
        tableView.yi_isScrollEnabled = true
        view.addSubview(tableView)
        
//        tableView.yi_viewForHeaderInSection({ (tab, sec) -> UIView in
//            let view = UIView()
//            if sec == 0 {
//                view.backgroundColor = .red
//            } else {
//                view.backgroundColor = .gray
//            }
//            return view
//        }).yi_numberOfSections({ (tab) -> (Int) in
//            return 10
//        }).yi_heightHeaderSection(100)
//        tableView.yi_viewForFooterInSection { (tab, sec) -> UIView in
//
//        }.yi_numberOfSections { (tab) -> (Int) in
//            
//        }
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
//        QYRatio(1)
        
        yi_addTableView(.grouped) { (tab) in
            
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

