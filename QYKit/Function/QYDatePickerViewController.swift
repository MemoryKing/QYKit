/*******************************************************************************
Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit

struct QYScreenInfo {
    static let Frame = UIScreen.main.bounds
    static let Height = Frame.height
    static let Width = Frame.width
    static let navigationHeight:CGFloat = navBarHeight()

    static func isIphoneX() -> Bool {
        return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
    }
    static private func navBarHeight() -> CGFloat {
        return isIphoneX() ? 88 : 64
    }
}

class QYDatePickerViewController: UIViewController {

    var backDate: ((String) -> Void)?
    let startTime = 2016
    var picker: UIPickerView!
    ///获取当前日期
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day],   from: Date())    //日期类型
    var containV:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: QYScreenInfo.Height-240, width: QYScreenInfo.Width, height: 240))
        view.backgroundColor = UIColor.white
        return view
    }()
    var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showDatePicker(backDate : @escaping ((String) -> Void)) {
        self.backDate = backDate
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.drawMyView()
    }
    // MARK: - Func
    private func drawMyView() {
        self.view.insertSubview(self.backgroundView, at: 0)
        //viewcontroller弹出后之前控制器页面不隐藏 .custom代表自定义
        self.modalPresentationStyle = .custom
        let cancel = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        let sure = UIButton(frame: CGRect(x: QYScreenInfo.Width - 70, y: 0, width: 70, height: 30))
        cancel.setTitle("取消", for: .normal)
        sure.setTitle("确认", for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sure.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancel.setTitleColor(UIColor.init(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1), for: .normal)
        sure.setTitleColor(UIColor.init(red: 28 / 255.0, green: 129 / 255.0, blue: 254 / 255.0, alpha: 1), for: .normal)
        cancel.addTarget(self, action: #selector(self.onClickCancel), for: .touchUpInside)
        sure.addTarget(self, action: #selector(self.onClickSure), for: .touchUpInside)
        picker = UIPickerView(frame: CGRect(x: 0, y: 30, width: QYScreenInfo.Width, height: 210))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.clear
        picker.clipsToBounds = true
        self.containV.addSubview(cancel)
        self.containV.addSubview(sure)
        self.containV.addSubview(picker)
        self.view.addSubview(self.containV)
    }
    // MARK: on Cancel Click
    @objc func onClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: on Sure Click
    @objc func onClickSure() {
        let dateString = String(format: "%02ld-%02ld", self.picker.selectedRow(inComponent: 0) + startTime, self.picker.selectedRow(inComponent: 1) + 1)
        /// 直接回调显示
        if self.backDate != nil {
            self.backDate!(dateString)
        }
        /*** 如果需求需要不能选择已经过去的日期
         let dateSelect = dateFormatter.date(from: dateString)
         let date = Date()
         let calendar = Calendar.current
         let dateNowString = String(format: "%02ld-%02ld-%02ld", calendar.component(.year, from: date) , calendar.component(.month, from: date), calendar.component(.day, from: date))

        /// 判断选择日期与当前日期关系
        let result:ComparisonResult = (dateSelect?.compare(dateFormatter.date(from: dateNowString)!))!

        if result == ComparisonResult.orderedAscending {
            /// 选择日期在当前日期之前,可以选择使用toast提示用户.
            return
            }else{
            /// 选择日期在当前日期之后. 正常调用
            if self.backDate != nil{
                self.backDate!(dateFormatter.date(from: dateString) ?? Date())
            }
        }
         */
        self.dismiss(animated: true, completion: nil)
    }
    ///点击任意位置view消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let currentPoint = touches.first?.location(in: self.view)
        if !self.containV.frame.contains(currentPoint ?? CGPoint()) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// MARK: - PickerViewDelegate
extension QYDatePickerViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 10
        } else if component == 1 {
            return 12
        } else {
            let year: Int = pickerView.selectedRow(inComponent: 0) + currentDateCom.year!
            let month: Int = pickerView.selectedRow(inComponent: 1) + 1
            let days: Int = howManyDays(inThisYear: year, withMonth: month)
            return days
        }
    }
    private func howManyDays(inThisYear year: Int, withMonth month: Int) -> Int {
        if (month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12) {
            return 31
        }
        if (month == 4) || (month == 6) || (month == 9) || (month == 11) {
            return 30
        }
        if (year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3) {
            return 28
        }
        if year % 400 == 0 {
            return 29
        }
        if year % 100 == 0 {
            return 28
        }
        return 29
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return QYScreenInfo.Width / 2
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(startTime + row)\("年")"
        } else if component == 1 {
            return "\(row + 1)\("月")"
        } else {
            return "\(row + 1)\("日")"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if component == 1 {
//            pickerView.reloadComponent(2)
//        }
    }
    
}

// MARK: - 转场动画delegate
extension QYDatePickerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = QYDatePickerViewControllerAnimated(type: .present)
        return animated
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = QYDatePickerViewControllerAnimated(type: .dismiss)
        return animated
    }
}



enum DatePickerPresentAnimateType {
    case present//被推出时
    case dismiss//取消时
}

//DatePickerViewController的推出和取消动画
class QYDatePickerViewControllerAnimated: NSObject,UIViewControllerAnimatedTransitioning {

    var type: DatePickerPresentAnimateType = .present

    init(type: DatePickerPresentAnimateType) {
        self.type = type
    }
    /// 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    /// 动画效果
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        switch type {
        case .present:
            guard let toVC = transitionContext.viewController(forKey: .to) as? QYDatePickerViewController else {
                return
            }
//            let toVC : DatePickerViewController = transitionContext.viewController(forKey: .to) as? DatePickerViewController
            let toView = toVC.view

            let containerView = transitionContext.containerView
            containerView.addSubview(toView!)

            toVC.containV.transform = CGAffineTransform(translationX: 0, y: (toVC.containV.frame.height))

            UIView.animate(withDuration: 0.25, animations: {
                /// 背景变色
                toVC.backgroundView.alpha = 1.0
                /// datepicker向上推出
                toVC.containV.transform =  CGAffineTransform(translationX: 0, y: -10)
            }) { ( _ ) in
                UIView.animate(withDuration: 0.2, animations: {
                    /// transform初始化
                    toVC.containV.transform = CGAffineTransform.identity
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
                })
            }
        case .dismiss:
            guard let toVC = transitionContext.viewController(forKey: .from) as? QYDatePickerViewController else {
                return
            }
            UIView.animate(withDuration: 0.25, animations: {
                toVC.backgroundView.alpha = 0.0
                /// datepicker向下推回
                toVC.containV.transform =  CGAffineTransform(translationX: 0, y: (toVC.containV.frame.height))
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
}
