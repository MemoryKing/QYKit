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
struct HomeAPI {
    static let login = "http://192.168.16.198:8011/jjf-api/login"
    static let img = "http://192.168.16.198:8011/jjf-api/api/common/uploadHeadImage"
}
class QYRequest: QYAlamofire {

    override func yi_configureRequestParameters() {
//        super.yi_configureRequestParameters()
        self.timeOut = 8
    }
    
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
//        var ss = "123133wqer"
//        let aa = ss.yi_deleteLast()
        
//        QYLog("\(ss) + \(aa)")
        
        let str = "{\"ss\":\"0.003880\",\"name\":null}"
        model = try? Presonewe.yi_init(str.yi_toDictionary())
        
//        QYLog(model?.name?.string ?? "123")
//        QYLog(model?.ss?.string ?? "0.0000000")
//        QYLog(model?.ss?.double ?? 0.0000000)
        
        QYLog("1234567890".yi_index(after: 3))
        
        ceshi1()
    }
    func ceshi3() {
        
        let brn = UIButton.init().yi_then({
            $0.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            $0.frame = self.view.bounds
            view.addSubview($0)
        })
        
        brn.yi_clickAction = {
            
            
            
//            "https://beifuqi.sandpay.com.cn/jjf-api/login"
//            var para = [String: Any]()
//            para["username"] = "18250808695"
//            para["password"] = "123456"
//            para["rememberMe"] = "false"
//            QYRequest().post(HomeAPI.login, para) { (model: MyInfo_Data) in
//
//                QYLog(model.id)
//                let image = UIImage.init(named: "WeChat66467de1e87eb0c1de1a8add1099df0b")
//                QYRequest().uploadImage(HomeAPI.img, fileParam: "headImageFile", files: [image!], progressHandler: nil) { (json) in
//                    QYLog(json)
//                } error: { (json) in
//                    QYLog(json)
//                }
//            } error: { (err) in
//                QYLog(err)
//            }

//            QYHUD.shared.locationStatus = .top
//            QYHUD.yi_show("这下吧发是这下吧发是这下吧发是这下吧发是") {
//                QYLog("12333333333333333333")
//                self.yi_push(MyViewController())
//            }
//            QYSystem.yi_invokeCameraPhoto(nil)
            
//            QYAlert.yi_show {
//                QYHUD.yi_show("这下吧发是这下吧发是这下吧发是这下吧发是") {
//                    QYLog("12333333333333333333")
//                    self.yi_push(MyViewController())
//                }
//            }
            
            
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
        tableView.yi_dataCount = 18
        tableView.yi_cellForRowAtIndexPath { (tab, index) -> UITableViewCell in
            return UITableViewCell()
        }.yi_numberOfRowsInSection { (tab, int) -> (Int) in
            return self.tableView.yi_page * self.tableView.yi_pageNumber
        }
        
        tableView.yi_didSelectRowAtIndexPath { (tab, indexPath) in
            QYLog(indexPath)
        }
        
        tableView.yi_refreshFooter {
            DispatchQueue.main.yi_after(1) {
                self.tableView.reloadData()
            }
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


struct MyInfo_Data: QYCodable {
    var vipOverTime: Double?
    var activateTime: String?
    var creator: String?
    var recStatus: String?
    var isTwiceMonthReach: String?
    var creditCardNo: String?
    var isVipFirst: QYStrInt?
    var id: String?
    var vipOpenTime: String?
    var password: String?
    var nextMonthReachTime: String?
    var merchantCode: String?
    var unbindTime: String?
    var twiceMonthReachTime: String?
    var realName: String?
    var isNextMonthReach: String?
    var salt: String?
    var mobilePhone: String?
    var modifyTime: String?
    var merchantStatus: String?
    var isVip: Bool?
    var reachTime: String?
    var bindTime: String?
    var identityNo: String?
    var debitCardNo: String?
    var modifier: String?
    var merchantName: String?
    var merchantType : String?
    var avatar: String?
    var createTime: String?
    var authStatus: String?
    var version  : String?
    var sumScore : String?
    
}


func dealWithRequestByParams(params:[String:Any]) -> [String:Any]  {
    if params.count == 0 {
        return [:]
    }
    var bodyStr:String = ""
    for key in params.keys {
        bodyStr += String.init(format: "%@=%@&", key,params[key] as! CVarArg)
    }
    
    let encWithPubKey = RSA.encryptString(bodyStr, publicKey: RSA_PublicKey)
    var para:[String:Any] = [:]
    para["data"] = encWithPubKey
    para["encrypted"] = "Y"
    para["pos"] = "bpos"
    return para
}

var RSA_PrivateKey:String = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAIgz14Bw7f1RjJOvcwOJQ/B+zB2GeJPBVwaGzwZSGroGQ9HNkTs1BnUnd3zF7PaUr7bXI+a+HXc4DG+b2UW2nIY1QtbtHWlpyhgrtuwpBPL1g9j9Ltk2zcSixyWLcs9bKgj5C0NuTlpnLyg4nMYKTXmSl3lk4NMzP+4wXSVaz9/nAgMBAAECgYBXdhLYY6wvkwJWg7+zcZ2y/XlNLGCZYPnlMwQV5vtKoWNDgmHUR0SSTnmoIeD8ppX/Lz/amBKLz+4MbWOkJJN1me2bvOvM5SLgSpOjbIPTlZHzOgR2qUyVJnbUxGVweAmMJUTQDSfYQHvnRYdgCLgsjpF4Nk3YDz0Fyj1bQubAwQJBAM+Mc9WkVHqzgxWruJZd5OjkcE38fRVK40nWxYiv1WEKt/WQUiJk1Reih+pUNJm1jl6CuBCqmLJNL4F4n0ALGmkCQQCn/5fBdg2zmN+CfkG1gD6I+cYxi/J+ZGa+KVE4sWED6n1tXlgWpkH7NnFV9NTKf/4LViS6TC+rVBeS0YLd5r3PAkAe/PB6kHuQimbjAG2h/cjkwN7HthAS8sh2yNtbai1ovMn0nyS0P+vVCI5UfVgRLxtfnxLOYjpEPOP/57uXO1EpAkBLZSXSKQ0VIPKOOeN7dUabap1L9yapGp4RkbFl5BVKEJ6hysl1wL+z4kcS8IHfL3nv1IU/JpnuJhs+RNCajcd5AkEAjwnuP5xJVHB4GIE297Ku7b/0bxF69EnytTacnSO4OjmitsUd4UDaSn1A6vfb9TnIWWozeCTrGAHf2FenciopyQ=="
var RSA_PublicKey:String = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCIM9eAcO39UYyTr3MDiUPwfswdhniTwVcGhs8GUhq6BkPRzZE7NQZ1J3d8xez2lK+21yPmvh13OAxvm9lFtpyGNULW7R1pacoYK7bsKQTy9YPY/S7ZNs3Eoscli3LPWyoI+QtDbk5aZy8oOJzGCk15kpd5ZODTMz/uMF0lWs/f5wIDAQAB"
