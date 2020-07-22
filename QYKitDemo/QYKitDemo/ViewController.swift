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


class ViewController: UIViewController {

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
        let string = "4d31303630687474703a2f2f36312e3132392e37312e3130333a393033382f656d752f7265732f32303230303731353135313834323031393731353935393135334d3230323632303230303731353135313834323031393731353935393135"
//        yPrintLog(string.yi_hexToString())
//        string.baseImage()
        string.yi_removeTrimming()
//        string.yi
//        string.yi_
        let arr = Array<Any>()
//        yPrintLog("M1060http://61.129.71.103:9038/emu/res/20200715151842019715959153M20262020071515184201971595915".yi_toHexString())
//        self.tableView.frame = self.view.frame
//        self.view.addSubview(self.tableView)
//        self.tableView._yi_empty_image = UIImage.init(named: "NoData")
    }
//    lazy var tableView : QYBaseTableView = {
//        let table = QYBaseTableView.init(frame: CGRect.zero, style: .grouped)
//        table.delegate = self
//        table.dataSource = self
//        table.separatorStyle = .none
//        return table
//    }()
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        QYDatePickerViewController.yi_showDatePicker(type: .day) { (str) in
//            QYHUD.show(str)
//        }
//    }
}

//MARK: -------   TableViewDelegate
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
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
