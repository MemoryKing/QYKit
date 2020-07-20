/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit
import MJRefresh
import DZNEmptyDataSet

class QYBaseCollectionView : UICollectionView {

    var yi_empty_title              : String?   = "暂无数据"
    var yi_empty_titleFont          : UIFont    = UIFont.systemFont(ofSize: 15)
    var yi_empty_titleColor         : UIColor   = .lightGray
    
    var yi_empty_description        : String?
    var yi_empty_descriptionFont    : UIFont    = UIFont.systemFont(ofSize: 15)
    var yi_empty_descriptionColor   : UIColor   = .lightGray
    var _yi_empty_image             : UIImage?
    var yi_empty_image              : UIImage? {
        set {
            _yi_empty_image = newValue
            self.reloadTableView()
        }
        get {
            return _yi_empty_image
        }
    }
    
    var yi_empty_btn_title          : String?
    var yi_empty_btn_titleFont      : UIFont    = UIFont.systemFont(ofSize: 15)
    var yi_empty_btn_titleColor     : UIColor   = .lightGray
    var _yi_empty_btn_image         : UIImage?
    var yi_empty_btn_image          : UIImage? {
        set {
            _yi_empty_btn_image = newValue
            self.reloadTableView()
        }
        get {
            return _yi_empty_btn_image
        }
    }
    
    var yi_spaceHeight              : CGFloat   = 10.0
    var yi_verticalOffset           : CGFloat   = 0
    var yi_backgroundColor          : UIColor   = .clear
    
    var clickBlock                  : (() -> Void)? = nil
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -------   MJRefresh 刷新与加载
extension QYBaseCollectionView {
    ///下拉
    func yi_refreshNormakHeader (_ refreshingBlock : @escaping () -> Void) {
        let header = MJRefreshNormalHeader.init(refreshingBlock: refreshingBlock)
        self.mj_header = header
    }
    
    ///动画下拉
    func yi_refreshGifHeader (_ refreshingBlock: @escaping () -> Void) {
        let header = MJRefreshGifHeader.init(refreshingBlock: refreshingBlock)
        self.mj_header = header
    }
    
    ///上拉
    func yi_refreshFooter (_ refreshingBlock: @escaping () -> Void) {
        let footer = MJRefreshBackNormalFooter.init(refreshingBlock: refreshingBlock)
        self.mj_footer = footer
    }
    
    ///提示没有更多的数据
    func yi_endRefreshingWithNoMoreData (){
        self.mj_footer?.endRefreshingWithNoMoreData()
    }
    
    ///结束刷新状态
    func yi_endRefreshing () {
        self.mj_header?.endRefreshing()
        self.mj_footer?.endRefreshing()
    }
}

//MARK: -------   DZNEmptyDataSet  空界面
extension QYBaseCollectionView : DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    func yi_empty_button(title:String , _ bl: (() -> Void)?) {
        self.yi_empty_title = nil
        self.yi_empty_btn_title = title
        self.clickBlock = bl
        self.reloadTableView()
    }
    
    //MARK: -- DZNEmptyDataSetSource Methods
    ///标题为空的数据集
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSAttributedString.Key.font: self.yi_empty_titleFont,
                          NSAttributedString.Key.foregroundColor: self.yi_empty_titleColor]
        return (self.yi_empty_title != nil) ? NSAttributedString(string: self.yi_empty_title!, attributes: attributes) : nil
    }
    ///描述
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
       
       let paragraph = NSMutableParagraphStyle()
       paragraph.alignment = .center
       paragraph.lineSpacing = CGFloat(NSLineBreakMode.byWordWrapping.rawValue)
        let attributes = [NSAttributedString.Key.font: self.yi_empty_descriptionFont,
                          NSAttributedString.Key.foregroundColor: self.yi_empty_descriptionColor,
                          NSAttributedString.Key.paragraphStyle: paragraph]
        
        return (self.yi_empty_description != nil) ? NSAttributedString(string: self.yi_empty_description!, attributes: attributes) : nil
    }
    ///图片
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return (self.yi_empty_image != nil) ? self.yi_empty_image : nil
    }
    ///数据集加载动画
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
       let animation = CABasicAnimation(keyPath: "transform")
       animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
       animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0.0, 0.0, 1.0))
       animation.duration = 0.25
       animation.isCumulative = true
       animation.repeatCount = MAXFLOAT
       return animation as CAAnimation
    }
    ///按钮标题
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let attributes = [NSAttributedString.Key.font : self.yi_empty_btn_titleFont,
                          NSAttributedString.Key.foregroundColor : self.yi_empty_btn_titleColor]
        return (self.yi_empty_btn_title != nil) ? NSAttributedString(string: self.yi_empty_btn_title!, attributes: attributes) : nil
    }

    ///重新加载按钮背景图片
    func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        return (self.yi_empty_image != nil) ? self.yi_empty_image : nil
       
    }
    ///自定义背景颜色
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return self.yi_backgroundColor
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return self.yi_verticalOffset
    }

    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return self.yi_spaceHeight
    }

    //MARK: -- DZNEmptyDataSetDelegate
    ///数据源为空时是否渲染和显示 (默认为 YES)
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
       return true
    }
    ///是否允许点击 (默认为 YES)
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
       return true
    }
    ///是否允许滚动(默认为 NO)
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
       return false
    }

    ///是否允许动画(默认为 NO)
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
       return false
    }
    ///视图触发
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        if self.clickBlock != nil {
            self.clickBlock!()
        }
    }
    ///按钮触发
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if self.clickBlock != nil {
            self.clickBlock!()
        }
    }

    fileprivate func reloadTableView(){
       self.reloadData()
       self.reloadEmptyDataSet()
    }
}



