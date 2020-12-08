/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/MemoryKing
********************************************************************************/


import UIKit
import SnapKit

open class QYBaseViewController: UIViewController {
    //MARK: --- 状态栏
    private var _barStyle: UIStatusBarStyle?
    ///状态栏
    public var yi_barStyle: UIStatusBarStyle {
        set {
            _barStyle = newValue
            setNeedsStatusBarAppearanceUpdate()
        }
        get {
            return _barStyle ?? UIStatusBarStyle.default
        }
    }
    
    //MARK: --- 返回手势
    private var _openPopGecognizer: Bool?
    ///返回手势
    public var yi_openPopGecognizer: Bool {
        set {
            _openPopGecognizer = newValue
            navigationController?.yi_openPopGecognizer = newValue
            navigationController?.interactivePopGestureRecognizer?.isEnabled = newValue
        }
        get {
            return _openPopGecognizer ?? false
        }
    }
    ///区头区尾悬停
    public var isHover: Bool?
    public var mainTableView: QYBaseTableView?
    public var mainCollection: QYBaseCollectionView?
    //MARK: --- viewDidLoad
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        //防止自动下移64
        automaticallyAdjustsScrollViewInsets = false
        
        extendedLayoutIncludesOpaqueBars = true
        
        yi_openPopGecognizer = true
        
        view.backgroundColor = QYF5Color
        yi_configureLayout()
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    ///界面布局
    open func yi_configureLayout() {
        
    }
    
    //MARK: --- 添加表视图
    ///添加表视图
    public func yi_addTableView(_ style: UITableView.Style? = nil, _ block: ((QYBaseTableView) -> Void)? = nil) {
        
        if mainCollection != nil {
            mainCollection?.removeFromSuperview()
            mainCollection = nil
        }
        
        mainTableView = QYBaseTableView(frame: .zero, style: style ?? .plain)
        if let tab = mainTableView {
            tab.showsVerticalScrollIndicator = false
            tab.showsHorizontalScrollIndicator = false
            tab.backgroundColor = QYF5Color
            tab.separatorStyle = .none
            tab.estimatedRowHeight = 44
            tab.estimatedSectionFooterHeight = 0
            tab.estimatedSectionHeaderHeight = 0
            view.addSubview(tab)
            var top: CGFloat
            var bottom: CGFloat
            if let _ = navigationController {
                top = QYStatusAndNavHeight
            } else {
                top = QYStatusHeight
            }
            if let _ = tabBarController {
                bottom = QYBottomAndTabBarHeight
            } else {
                bottom = QYBottomHeight
            }
            tab.snp.makeConstraints {
                $0.top.equalTo(top)
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalTo(-bottom)
            }
            block?(tab)
        }
    }
    
    //MARK:-注册表视图cell
    ///注册表视图cell
    public func yi_registerCell(cells: [AnyClass],cellName: [String]) {
        for index in 0..<cells.count {
            mainTableView?.register(cells[index], forCellReuseIdentifier: cellName[index])
        }
    }
    ///注册表视图cell
    public func yi_registerCell(cells: [AnyClass]) {
        for index in 0..<cells.count {
            mainTableView?.register(cells[index], forCellReuseIdentifier: NSStringFromClass(cells[index]))
        }
    }
    ///注册表视图cell
    public func yi_registerCell(cells: AnyClass) {
        mainTableView?.register(cells, forCellReuseIdentifier: NSStringFromClass(cells))
    }
    ///注册表视图cell
    public func yi_registerCell(cell: AnyClass,cellName: String) {
        mainTableView?.register(cell, forCellReuseIdentifier: cellName)
    }
    ///注册表视图nib cell
    public func yi_registerCell(cellNib: String,cellNameNib: String) {
        mainTableView?.register(UINib.init(nibName: cellNib, bundle: nil), forCellReuseIdentifier: cellNameNib)
    }
    ///注册表视图nib cell
    public func yi_registerCell(cellNibs:[String],cellNibName:[String]) {
        for index in 0 ..< cellNibs.count {
            mainTableView?.register(UINib.init(nibName: cellNibs[index], bundle: nil), forCellReuseIdentifier: cellNibName[index])
        }
    }
    
    
    //MARK: --- 添加集合视图
    ///添加集合视图
    public func yi_addCollectionView(_ block: ((UICollectionViewFlowLayout,QYBaseCollectionView) -> Void)? = nil) {
        if mainTableView != nil {
            mainTableView?.removeFromSuperview()
            mainTableView = nil
        }
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize.init(width: 100, height: 100)
        mainCollection = QYBaseCollectionView.init(frame: .init(), collectionViewLayout: layout)
        if let col = mainCollection {
            col.showsVerticalScrollIndicator = false
            col.showsHorizontalScrollIndicator = false
            col.backgroundColor = QYF5Color
            view.addSubview(col)
            col.snp.makeConstraints {
                $0.top.equalTo(QYStatusAndNavHeight)
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.bottom.equalTo(-QYBottomHeight)
            }
            block?(layout,col)
        }
        
    }
    
    //MARK:-注册集合视图cell
    ///注册集合视图cell
    public func yi_registerCollectionCell(cell:AnyClass,cellName:String) {
        mainCollection?.register(cell, forCellWithReuseIdentifier: cellName)
    }
    ///注册集合视图cell
    public func yi_registerCollectionCell(cells:[AnyClass],cellName:[String]) {
        for index in 0..<cells.count {
            mainCollection?.register(cells[index], forCellWithReuseIdentifier: cellName[index])
        }
    }
    ///注册集合视图nib cell
    public func yi_registerCollectionCell(cellNib:String,cellNameNib:String) {
        mainCollection?.register(UINib.init(nibName: cellNib, bundle: nil), forCellWithReuseIdentifier: cellNameNib)
    }
    ///注册集合视图nib cell
    public func yi_registerCollectionCell(cellNibs:[String],cellNibName:[String]) {
        for index in 0 ..< cellNibs.count {
            mainCollection?.register(UINib.init(nibName: cellNibs[index], bundle: nil), forCellWithReuseIdentifier: cellNibName[index])
        }
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return yi_barStyle
    }
}

extension QYBaseViewController : UIScrollViewDelegate {
    //MARK: --- header、footer均不悬停
    //header、footer均不悬停
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isHover ?? false {
            //组头高度
            let sectionHeaderHeight:CGFloat = 30
            //组尾高度
            let sectionFooterHeight:CGFloat = 30
             
            //获取是否有默认调整的内边距
            let defaultEdgeTop:CGFloat = navigationController?.navigationBar != nil
                && automaticallyAdjustsScrollViewInsets ? 64 : 0
             
            //上边距相关
            var edgeTop = defaultEdgeTop
            if scrollView.contentOffset.y >= -defaultEdgeTop &&
                scrollView.contentOffset.y <= sectionHeaderHeight - defaultEdgeTop  {
                edgeTop = -scrollView.contentOffset.y
            }
            else if (scrollView.contentOffset.y >= sectionHeaderHeight - defaultEdgeTop) {
                edgeTop = -sectionHeaderHeight + defaultEdgeTop
            }
             
            //下边距相关
            var edgeBottom:CGFloat = 0
            let b = scrollView.contentOffset.y + scrollView.frame.height
            let h = scrollView.contentSize.height - sectionFooterHeight
             
            if b <= h {
                edgeBottom = -30
            }else if b > h && b < scrollView.contentSize.height {
                edgeBottom = b - h - 30
            }
             
            //设置内边距
            scrollView.contentInset = UIEdgeInsets(top: edgeTop, left: 0, bottom: edgeBottom, right: 0)
        }
    }
}
