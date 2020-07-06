//
//  ViewController.swift
//  YJSwiftKit
//
//  Created by Mac on 2020/6/19.
//  Copyright © 2020 祎. All rights reserved.
//

import UIKit

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
        self.tableView.frame = self.view.frame
        self.view.addSubview(self.tableView)
        self.tableView._yi_empty_image = UIImage.init(named: "NoData")
    }
    lazy var tableView : BaseTableView = {
        let table = BaseTableView.init(frame: CGRect.zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        YJHUD.showSuccess("sdafghj")
    }
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
