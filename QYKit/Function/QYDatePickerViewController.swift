/*******************************************************************************
Copyright (K), 2019 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ 
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/

import UIKit

public enum QYComponentsType : Int {
    case year = 0
    case month = 1
    case day = 2
}

public class QYDatePickerViewController: UIViewController {
    
    private var type : QYComponentsType?
    private var backDate: ((String) -> Void)?
    private var startTime = 2016
    var picker: UIPickerView!
    ///获取当前日期
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())    //日期类型
    var containV:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: QYScreenInfo.height - QYScreenInfo.ratio(240), width: QYScreenInfo.width, height: QYScreenInfo.ratio(240)))
        view.backgroundColor = UIColor.white
        return view
    }()
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Func
    private var cancel: UIButton!
    private var sure: UIButton!
    private func drawMyView() {
        self.view.insertSubview(self.backgroundView, at: 0)
        self.modalPresentationStyle = .custom
        cancel = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        sure = UIButton(frame: CGRect(x: QYScreenInfo.width - QYScreenInfo.ratio(70), y: 0, width: QYScreenInfo.ratio(70), height: QYScreenInfo.ratio(30)))
        cancel.setTitle("取消", for: .normal)
        sure.setTitle("确认", for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sure.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancel.setTitleColor(UIColor.init(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1), for: .normal)
        sure.setTitleColor(UIColor.init(red: 28 / 255.0, green: 129 / 255.0, blue: 254 / 255.0, alpha: 1), for: .normal)
        cancel.addTarget(self, action: #selector(self.onClickCancel), for: .touchUpInside)
        sure.addTarget(self, action: #selector(self.onClickSure), for: .touchUpInside)
        picker = UIPickerView(frame: CGRect(x: 0, y: QYScreenInfo.ratio(30), width: QYScreenInfo.width, height: QYScreenInfo.ratio(210)))
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
        var dateString = ""
        switch self.type {
        case .year:
            dateString = String(format: "%02ld",
                                self.picker.selectedRow(inComponent: 0) + startTime)
        case .month:
            dateString = String(format: "%02ld-%02ld",
                                self.picker.selectedRow(inComponent: 0) + startTime,
                                self.picker.selectedRow(inComponent: 1) + 1)
        case .day:
            dateString = String(format: "%02ld-%02ld-%02ld",
                                self.picker.selectedRow(inComponent: 0) + startTime,
                                self.picker.selectedRow(inComponent: 1) + 1,
                                self.picker.selectedRow(inComponent: 2) + 1)
        case .none:
            break
        }
        if self.backDate != nil {
            self.backDate!(dateString)
        }
        self.dismiss(animated: true, completion: nil)
    }
    ///点击任意位置view消失
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// MARK: - PickerViewDelegate
extension QYDatePickerViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch self.type {
        case .year:
            return 1
        case .month:
            return 2
        default:
            break
        }
        return 3
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch self.type {
        case .year:
            return QYScreenInfo.width
        case .month:
            return QYScreenInfo.width / 2
        default:
            break
        }
        return QYScreenInfo.width / 3
    }
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(startTime + row)\("年")"
        } else if component == 1 {
            return "\(row + 1)\("月")"
        } else {
            return "\(row + 1)\("日")"
        }
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch self.type {
        case .year:break
        case .month:
            if component == 0 {
                pickerView.reloadComponent(1)
            }
        case .day:
            if component == 1 {
                pickerView.reloadComponent(2)
            }
        default:
            break
        }
    }
}
enum DatePickerPresentAnimateType {
    case present//被推出时
    case dismiss//取消时
}
// MARK: - 转场动画delegate
extension QYDatePickerViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = QYDatePickerViewControllerAnimated(type: .present)
        return animated
    }
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = QYDatePickerViewControllerAnimated(type: .dismiss)
        return animated
    }
}
//DatePickerViewController的推出和取消动画
private class QYDatePickerViewControllerAnimated: NSObject,UIViewControllerAnimatedTransitioning {

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

//MARK: -------   调用方法
extension QYDatePickerViewController {
    ///类型
    public class func yi_showDatePicker(type : QYComponentsType,
                                        _ startTime : Int? = 2016,
                                        _ backDate : @escaping ((String) -> Void)) {
        QYDatePickerViewController.yi_showDatePicker(type: type, startTime, "取消",nil,nil, "确定",nil,nil, backDate)
    }
    ///类型按钮文本
    public class func yi_showDatePicker(type : QYComponentsType,
                                        _ startTime : Int?,
                                        _ cancel: String,
                                        _ sure: String,
                                        _ backDate : @escaping ((String) -> Void)) {
        QYDatePickerViewController.yi_showDatePicker(type: type, startTime, cancel,nil,nil, sure,nil,nil, backDate)
    }
    ///类型按钮文本丶颜色
    public class func yi_showDatePicker(type : QYComponentsType,
                                        _ startTime : Int?,
                                        _ cancel: String,
                                        _ cancelColor: UIColor? = .blue,
                                        _ cancelFont: CGFloat?,
                                        _ sure: String,
                                        _ sureColor: UIColor? = .blue,
                                        _ sureFont: CGFloat?,
                                        _ backDate : @escaping ((String) -> Void)) {
        let vc = QYDatePickerViewController.init()
        vc.modalPresentationStyle = .fullScreen
        vc.type = type
        vc.startTime = startTime ?? 2016
        vc.backDate = backDate
        vc.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        vc.drawMyView()
        vc.cancel.setTitle(cancel, for: .normal)
        vc.cancel.setTitleColor(cancelColor, for: .normal)
        vc.cancel.titleLabel?.font = UIFont.systemFont(ofSize: QYScreenInfo.ratio(cancelFont ?? 15))
        vc.sure.setTitle(sure, for: .normal)
        vc.sure.setTitleColor(sureColor, for: .normal)
        vc.sure.titleLabel?.font = UIFont.systemFont(ofSize: QYScreenInfo.ratio(sureFont ?? 15))
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}
